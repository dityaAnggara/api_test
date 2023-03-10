<?php

namespace App\Controllers\Api\Auth;

use CodeIgniter\RESTful\ResourceController;
use CodeIgniter\API\ResponseTrait;
use App\Models\UserModel;
use Firebase\JWT\JWT;


class Login extends ResourceController
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
        $rules = [
            'email' => 'required|valid_email',
            'password' => 'required|min_length[6]'
        ];
        if(!$this->validate($rules)) return $this->fail($this->validator->getErrors());
        $model = new UserModel();
        $user = $model->where("email", $this->request->getVar('email'))->first();
        if(!$user) return $this->failNotFound('Email Not Found');
 
        $verify = password_verify($this->request->getVar('password'), $user['password']);
        if(!$verify) return $this->fail('Wrong Password');
 
        $startTime = date("Y-m-d H:i:s");
        $cenvertedTime = date('Y-m-d H:i:s',strtotime('+2 hour',strtotime($startTime)));
        $key = getenv('TOKEN_K');
        
        $payload = array(
            "uid" => $user['id'],
            "email" => $user['email'],
            "expired" => $cenvertedTime,
            "status" => "akses"

        );
        
        $payloadn = array(
            "uid" => $user['id'],
            "email" => $user['email'],
            "ref" => $startTime,
            "status" => "segar"

        );
        
       
            $token = JWT::encode($payload, $key, 'HS256');
            $tokenn = JWT::encode($payloadn, $key, 'HS256');
            $response = [
                'accessToken' => $token,
                'refreshToken' => $tokenn,
                'info' => [
                    '1 .' => 'Anda mendapatkan access token dan refresh token',
                    '2 .' => 'batas waktu access  token dan refresh token hanya berlaku 2 jam setelah token terbentuk',
                    '3 .' => 'gunakan access token untuk bertransaksi dalam system dan refresh token untuk mengganti access token anda',
                    '4 .' => 'jika access token sudah tidak berlaku anda harus login untuk mendapatkan access token kembali bukan dengan update token'
                ]
                
            ];
            $dataa = [
                'acces_t' => $tokenn,
                'expi' => $cenvertedTime
            ];
           
            $model->update($user['id'], $dataa);
            return $this->respond($response);
       
       // return $this->respond($token);
    }

    /**
     * Return the properties of a resource object
     *
     * @return mixed
     */
    public function show($id = null)
    {
        
        
       
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
