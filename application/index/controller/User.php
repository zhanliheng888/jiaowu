<?php
namespace app\index\controller;
use think\Controller;
use think\db;

/**
 * Class User 用户管理
 * @package app\index\controller
 */
class User extends Controller{
    //登录
    public function login(){
        if (request()->isGet()){
            //登录页面
            return $this->fetch();
        }elseif (request()->isPost()){
            //登录提交的数据处理
            $username = request()->param()['username'];
            $pdw = request()->param()['password'];
            $ip = request()->ip();
            $time = date('Y-m-d H:i:s');

            $user = model('user')
                ->where('uersname',$username)
                ->where('password',$pdw)
                ->find();

            $name = model('error')
                ->where('ip',$ip)
                ->select();
            foreach ($name as $k=>$v){
                $names[$k] = $v['error'];
                $times[$k] = strtotime($v['logintime']);
            }

            switch (count($names)){
                case 1:
                    $kk = $names[0];
                    break;
                case count($names) >= 2:
                    $kk = max($names);
                    break;
            }
//            var_dump($kk);die();
            //判断登录错误次数
            if (array_sum($names) >= 3){
                $ti = max($times);
                $t = time()-$ti;
                if ($t >= 60){
                    session('num',null);
                    model('error')
                        ->where('ip',$ip)
                        ->update([
                            'error'=>0
                        ]);
                }else{
                    $this->error('您输入密码错误已达三次，请等'.(60-$t).'秒',url('index/user/login'));
                }

            }

            //var_dump($user['id']);die();
            //判断是否登录成功
            if ($user){
                $admin = model('error')
                    ->where('uid',$user['id'])
                    ->find();
                //登陆成功，则传递一个session值并且跳转到后台首页
                if (!$admin){
                    model('error')
                        ->save([
                            'uid'=>$user['id'],
                            'ip'=>$ip,
                            'logintime'=>$time,
                            'error'=>0,
                        ]);
                }else{
                    model('error')
                        ->where('uid',$user['id'])
                        ->update([
                            'error'=>0,
                            'logintime'=>$time,
                        ]);
                }

                session('admin',$user);
                session('num',null);
                $this->success('登录成功！',url('index/index/index'));
            }else{
                $users = model('user')
                    ->where('uersname',$username)
                    ->find();
                $admin = model('error')
                    ->where('uid',$users['id'])
                    ->find();
                //登陆失败，重新跳转到登陆页面
                if (!session('?num')){
                    session('num',1);
                } else{
                    if (session('num') >= 3){
                        session('num',3);
                    }else{
                        $un = session('num')+1;
                        session('num',$un);
                    }

                }
                if (!$admin){
                    model('error')
                        ->save([
                            'uid'=>$users['id'],
                            'ip'=>$ip,
                            'logintime'=>$time,
                            'error'=>session('num'),
                        ]);
                }else{
                    model('error')
                        ->where('uid',$users['id'])
                        ->update([
                            'logintime'=>$time,
                            'error'=>session('num')
                        ]);
                }
                $this->error('登录失败！',url('index/user/login'));
            }
        }

    }

        /*
         * 后台管理员退出
         */
    public function logout(){
        session('admin',null);
        $this->redirect('index/user/login');
    }


}