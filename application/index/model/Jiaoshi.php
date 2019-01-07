<?php
namespace app\index\model;
use think\Model;

class Jiaoshi extends Model{
    static function get_list($id=''){
        if (!empty($id)){
            $where = ['j.id'=>$id];
        }else{
            $where = [];
        }
        $arr = model('jiaoshi')
            ->alias('j')
            ->field('j.*,x.xiname,k.kname')
            ->join('xueyuan x','x.id=j.xid')
            ->join('kecheng k','k.id=j.kid')
            ->where($where)
            ->paginate();
        return $arr;
    }
}