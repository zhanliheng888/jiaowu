<?php
namespace app\index\model;
use think\Model;

class Lianxi extends Model{
    /**
     * 获取不同的数组
     * @param $arr 前端传过来的答案
     * @param $num 获取个数
     * @param $type 题目种类
     */
    static function get_answer($arr,$num,$type){
        for ($i=1;$i<=$num;$i++){
            $dan[]="$type".$i;
        }
        $dans = [];
        foreach ($arr as $k=>$v){
            if (in_array($k,$dan)){
                $dans[]=$v;
            }

        }
        return $dans;
    }
}