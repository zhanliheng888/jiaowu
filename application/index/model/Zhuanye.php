<?php
namespace app\index\model;
use think\Model;

class Zhuanye extends Model{
     static function get_list($id=''){
         if (!empty($id)){
             $where = ['z.id'=>$id];
         }else{
             $where = [];
         }
        $arr = model('zhuanye')
            ->alias('z')
            ->field('z.*,x.xiname')
            ->join('xueyuan x','x.id=z.uid')
            ->where($where)
            ->paginate();
        return $arr;
    }
}