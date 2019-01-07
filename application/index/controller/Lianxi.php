<?php
namespace app\index\controller;
use app\common\controller\Base;
use app\index\model\Lianxi as lian;
use app\index\model\Question as que;

/**
 * Class Lianxi 考试管理—日常练习
 * @package app\index\controller
 */
class Lianxi extends Base{
    //日常练习首页
    public function index(){
        $dan = que::get_num(10,1,1); //单选
        $duo = que::get_num(5,1,2); //多选
        $pan = que::get_num(5,1,3); //判断
        $tian = que::get_num(5,1,4); //填空
        $uid = session('admin.id');
        $arr = [];
        $sa = model('lianxi')
            ->where('uid',$uid)
            ->find();
        $dans = model('question')
            ->where('id','in',$dan)
            ->select();
        $duos = model('question')
            ->where('id','in',$duo)
            ->select();
        $pans = model('question')
            ->where('id','in',$pan)
            ->select();
        $tians = model('question')
            ->where('id','in',$tian)
            ->select();
        $arr['uid'] = $uid;
        $arr['dans'] = serialize($dan);
        $arr['duos'] = serialize($duo);
        $arr['pans'] = serialize($pan);
        $arr['tians'] = serialize($tian);

        if ($sa){
            model('lianxi')
                ->where('uid',$uid)
                ->update($arr);
        }else{
            model('lianxi')
                ->save($arr);
        }
        $this->assign([
            'dans'=>$dans,
            'duos'=>$duos,
            'pans'=>$pans,
            'tians'=>$tians
        ]);

        return $this->fetch();
    }
    //日常练习-答案判断
    public function sub(){
        $arr = request()->param();
        $uid = session('admin.id');
        unset($arr['/index/lianxi/sub']);
        $dans = lian::get_answer($arr,10,'dan'); //获取学生单选题目答案
        $duos = lian::get_answer($arr,5,'duo'); //获取学生多选题目答案
        //将数组变为字符串
        foreach ($duos as $k=>$v){
            if (is_array($v)){
                $duos[$k]=rtrim(implode('/',$v),'/');
            }else{
                $duos[$k]=$v;
            }
        }
        $pans = lian::get_answer($arr,5,'pan'); //获取学生判断题目答案
        $tians = lian::get_answer($arr,5,'tian'); //获取学生判断题目答案

        //获取题目和答案
        $list = model('lianxi')
            ->where('uid',$uid)
            ->find();
        $danss = unserialize($list->dans); //题库单选id
        $duoss = unserialize($list->duos); //题库多选id
        $panss = unserialize($list->pans); //题库判断id
        $tianss = unserialize($list->tians); //题库填空id
        $dan = model('question')
            ->where('id','in',$danss)
            ->select();
        $duo = model('question')
            ->where('id','in',$duoss)
            ->select();
        $pan = model('question')
            ->where('id','in',$panss)
            ->select();
        $tian = model('question')
            ->where('id','in',$tianss)
            ->select();
        $this->assign([
            'dans'=>$dans,
            'duos'=>$duos,
            'pans'=>$pans,
            'tians'=>$tians,
            'dan'=>$dan,
            'duo'=>$duo,
            'pan'=>$pan,
            'tian'=>$tian
        ]);
        //var_dump($dans);die();
        return $this->fetch();
    }

}