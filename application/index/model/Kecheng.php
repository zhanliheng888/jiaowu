<?php
namespace app\index\model;
use think\Model;

class Kecheng extends Model{
    static function get_list($id=''){
        if (!empty($id)){
            $where = ['k.id'=>$id];
        }else{
            $where = [];
        }
        $arr = model('kecheng')
            ->alias('k')
            ->field('k.*,z.yename')
            ->join('zhuanye z','k.zid=z.id')
            ->where($where)
            ->paginate();
        return $arr;
    }
}