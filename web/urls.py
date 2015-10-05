#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os, re, time, base64, hashlib
import markdown2
from transwarp.web import ctx
from transwarp.web_append import seeother, notfound, get, post,view
from transwarp.apis import api, APIError, APIValueError, APIPermissionError, APIResourceNotFoundError
import urlparse

@view('index.html')#view类型的返回字典，用来渲染模板
@get('/index')
def signin():
    print ctx.request.para
    return dict(message="origin message")

@api
@get('/api/users')
def getuser():
    print ctx.request.para
    print "hello ..."
    # callback = ctx.request.para['callback']
    # res = '{0}({1})'.format(callback, {'a':1, 'b':2})
    resp = {"OK":"NOK"}
    print resp
    return resp

@api
@get('/api/admininfo')
def ALLusers():
    print ctx.request.para
    return {'id': '000','name': 'cairuyuan'}

@api
@post('/api/json')
def compute():
    print ctx.request.para
    
    urls = urlparse.urlparse(ctx.request.para['addr'])
    host = urls.netloc
    print host
    path = '/extractor/screenshot/'+host.replace('.','_')+'+.png'
    print path
    return {'res': ctx.request.para['addr'], 'path':path }


@api
@post('/api/json2')
def compute():
    print ctx.request.para
    url = ctx.request.para['res']
    uid = ctx.request.para['id']
    
    return {'score':12,'id':0 }