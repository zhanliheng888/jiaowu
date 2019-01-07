<?php
namespace app\index\model;
use think\Model;

class Student extends Model{
    static function get_list($id){
        $arr = model('student')
            ->alias('s')
            ->field('s.*,b.bname')
            ->join('banji b','b.id=s.bid')
            ->where('bid',$id)
            ->paginate();
        return $arr;
    }

}