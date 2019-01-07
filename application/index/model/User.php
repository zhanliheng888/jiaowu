<?php
namespace app\index\model;
use think\Model;


class User extends Model{
    static function get_list(){
        $arr = model('user')
            ->paginate();
        return $arr;
    }

    public function time(){
        return $this->belongsTo('Error','id','uid');
    }

}