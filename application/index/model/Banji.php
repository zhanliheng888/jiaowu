<?php
namespace app\index\model;
use think\Model;

class Banji extends Model{
    static function get_list(){
        $arr = model('banji')
            ->alias('b')
            ->field('b.*,z.yename')
            ->join('zhuanye z','z.id=b.zid')
            ->paginate();
        return $arr;
    }
}