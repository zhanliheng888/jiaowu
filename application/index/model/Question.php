<?php
namespace app\index\model;
use think\Model;

class Question extends Model{
    //仅供练习
    static function get_arr(){
        $arr = model('question')
            ->where('style',1)
            ->select();
        return $arr;
    }
    //仅供考试
    static function get_list(){
        $list = model('question')
            ->where('style',2)
            ->select();
        return $list;
    }

    public function timu(){
        return $this->belongsTo('kecheng','keid','id');
    }

    /**
     * 获取随机数
     * @param $type 题目类型
     * @param $number 题目个数
     * @param $slect  题目种类：1为日常练习及作业，2为仅供考试,3所有
     * @return array
     */
    static function get_num($number, $slect,$type)
    {
        if ($slect == 1) {
                $ra = model('Question')
                    ->field('id')
                    ->where('style', 1)
                    ->where('type',$type)
                    ->order('id desc')
                    ->select();

        } elseif ($slect == 2) {
                $ra = model('Question')
                    ->field('id')
                    ->where('style', 2)
                    ->where('type',$type)
                    ->order('id desc')
                    ->select();
        }elseif ($slect == 3){
            $ra = model('Question')
                ->field('id')
                ->where('type',$type)
                ->order('id desc')
                ->select();
        }

        $count = count($ra)-1;
        $max = 0;
        $min = $count;
        $i = 1;
        $num = [];
        while ($i <= $number) {
            $nu = rand($min, $max);
            if (!in_array($nu, $num)) {
                $num[] = $nu;
            } else {
                $i--;
            }
            $i++;
        }
        $nus = [];
        foreach ($ra as $k=>$v){
            if (in_array($k,$num)){
                $nus[] = $v->id;
            }
        }

        return $nus;
    }

}