%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc: : 
%%% Created :
%%% Node end point  
%%% Creates and deletes Pods
%%% 
%%% API-kube: Interface 
%%% Pod consits beams from all services, app and app and sup erl.
%%% The setup of envs is
%%% -------------------------------------------------------------------
-module(all).   
 
-export([start/0]).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

-define(ClusterSpec,"prototype_c201").
		 

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->
   
    ok=setup(),

  
    io:format("Test OK !!! ~p~n",[?MODULE]),
    init:stop(),
    ok.


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% -----------------------------------------------------------------------
-define(ClusterDir,"prototypec201").
setup()->
    io:format("Start ~p~n",[?FUNCTION_NAME]),
    os:cmd("rm -rf "++?ClusterDir),
    timer:sleep(2000),
    ok=file:make_dir(?ClusterDir),
    ok=application:set_env([{infra_service_app,[{cluster_spec,?ClusterSpec}]}]),

    {ok,_}=resource_discovery_server:start(),
    ok=application:start(infra_service_app),
      
    pong=db_etcd:ping(),
    pong=nodelog:ping(),
    pong=connect_server:ping(),
    pong=appl_server:ping(),
    pong=pod_server:ping(),
    pong=oam:ping(),
    pong=infra_service_server:ping(),

    io:format("Stop OK !!! ~p~n",[?FUNCTION_NAME]),

    ok.
