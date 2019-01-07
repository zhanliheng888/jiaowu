<?php
namespace app\index\model;
use think\Model;

class Kaoshi extends Model{
    /**
     * @param $danss 题目答案
     * @param $dans 学生答案
     * @param $fen 题目分数
     */
    static function get_fen($arrs,$arr,$fen){
        $dansf = 0;
        foreach ($arrs as $k=>$v){
            if ($v==$arr[$k]){
                $dansf += $fen;
            }
        }
        return $dansf;
    }
}