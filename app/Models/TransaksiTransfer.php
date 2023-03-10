<?php

namespace App\Models;

use CodeIgniter\Model;

class TransaksiTransfer extends Model
{
    protected $DBGroup          = 'default';
    protected $table            = 'transaksi_transfer';
    protected $primaryKey       = 'id';
    protected $useAutoIncrement = true;
    protected $insertID         = 0;
    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;
    protected $protectFields    = true;
    protected $allowedFields    = ['id_transaksi',
    'uid',
    'id_bank_pengirim',
    'id_bank_admin',
    'id_bank_tujuan',
    'kode_unik',
    'nilai_transfer',
    'biaya_admin',
    'total_transfer',
    'tanggal_transaksi'];


    // Dates
    protected $useTimestamps = false;
    protected $dateFormat    = 'datetime';
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';

    // Validation
    protected $validationRules      = [];
    protected $validationMessages   = [];
    protected $skipValidation       = false;
    protected $cleanValidationRules = true;

    // Callbacks
    protected $allowCallbacks = true;
    protected $beforeInsert   = [];
    protected $afterInsert    = [];
    protected $beforeUpdate   = [];
    protected $afterUpdate    = [];
    protected $beforeFind     = [];
    protected $afterFind      = [];
    protected $beforeDelete   = [];
    protected $afterDelete    = [];
}
