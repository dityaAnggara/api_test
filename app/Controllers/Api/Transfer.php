<?php

namespace App\Controllers\Api;

use CodeIgniter\RESTful\ResourceController;
use CodeIgniter\API\ResponseTrait;
use App\Models\UserModel;
use App\Models\TransaksiTransfer;
use App\Models\Bank;
use App\Models\RekeningAdmin;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;

class Transfer extends ResourceController
{
    /**
     * Return an array of resource objects, themselves in array format
     *
     * @return mixed
     */
    use ResponseTrait;
    public function index()
    {
        helper(['form']);
        $header = $this->request->getServer('HTTP_AUTHORIZATION');
        if(!$header) return $this->failUnauthorized('Token Required');
        $token = explode(' ', $header)[1];
       $rules = [
            'nilai_transfer' => 'required',
            'bank_tujuan' => 'required',
            'rekening_tujuan' => 'required',
            'atasnama_tujuan' => 'required',
            'bank_pengirim' => 'required'
        ];
        if(!$this->validate($rules)) return $this->fail($this->validator->getErrors());
        $key = getenv('TOKEN_K');
        $bkt = $this->request->getVar("bank_tujuan");
        $bbkt = $this->request->getVar("bank_pengirim");
        $model = new Bank();
        $bank = $model->where("nama_bank", $bkt)->get();
        $bannk = $model->where("nama_bank", $bbkt)->first();
        $mddl = new RekeningAdmin();
        $medl = new TransaksiTransfer();
        $reqh = $mddl->where("id_bank", $bannk["id_bank"])->first();
        $startTime = date("Y-m-d H:i:s");
        $cenvertedTime = date(DATE_ATOM,strtotime('+3 day',strtotime($startTime)));
        $biaya = 0;
        $dr = rand(100,999);
        ($bank->getNumRows() != 0) ? $biaya = 0 : $biaya =2500;
        try {
            $decoded = JWT::decode($token, new Key($key, 'HS256'));
            $ghu = new UserModel();
            $user = $ghu->where("email", $decoded->email)->first();
            $da = date('Y-m-d H:i:s');
            if(($da > $user['expi']) == true) return $this->fail('token anda expired, login sekali lagi untuk mendapatkan token');
            $nmodel = new TransaksiTransfer();
            $dtng = date("Y");
            $trt = $nmodel->like('tanggal_transaksi', $dtng,'after')->get();
            $idtrt = "TF".date("ymd")."".sprintf("%05d", ($trt->getNumRows()+1));
            $response = [
              "id_transaksi" => $idtrt,
              "nilai_transfer" => $this->request->getVar("nilai_transfer"),
              "kode_unik" => $dr,
              "biaya_admin" => $biaya,
             "total_transfer" => ($this->request->getVar("nilai_transfer")) + $dr + $biaya,
             "bank_perantara" => $this->request->getVar("bank_pengirim"),
             "rekening_perantara" => $reqh["no_rek"],
             "berlaku_hingga" => $cenvertedTime
            ];
           
            $dataa = [
                'id_transaksi' => $idtrt,
                'uid' => $decoded->uid,
                'id_bank_pengirim' => $bannk["id_bank"].":".$bbkt,
                'id_bank_admin' => $reqh["no_rek"].":".$this->request->getVar("bank_pengirim"),
                'id_bank_tujuan' => $bkt.":".$this->request->getVar("rekening_tujuan"),
                'kode_unik' => $dr,
                'nilai_transfer' => $this->request->getVar("nilai_transfer"),
                'biaya_admin' => $biaya,
                'total_transfer' => ($this->request->getVar("nilai_transfer")) + $dr + $biaya,
                'tanggal_transaksi' => date("Y-m-d H:i:s")
            ];
            $medl->save($dataa);
            return $this->respond($response);
        } catch (\Throwable $th) {
            return $this->fail($th);
        }
        //return $this->respond($token);
    }

    /**
     * Return the properties of a resource object
     *
     * @return mixed
     */
    public function show($id = null)
    {
        //
    }

    /**
     * Return a new resource object, with default properties
     *
     * @return mixed
     */
    public function new()
    {
        //
    }

    /**
     * Create a new resource object, from "posted" parameters
     *
     * @return mixed
     */
    public function create()
    {
        //
    }

    /**
     * Return the editable properties of a resource object
     *
     * @return mixed
     */
    public function edit($id = null)
    {
        //
    }

    /**
     * Add or update a model resource, from "posted" properties
     *
     * @return mixed
     */
    public function update($id = null)
    {
        //
    }

    /**
     * Delete the designated resource object from the model
     *
     * @return mixed
     */
    public function delete($id = null)
    {
        //
    }
}
