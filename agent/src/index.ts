import express from 'express';
import http from 'http';
import httpProxy from 'http-proxy';

const app = express();

var proxy = httpProxy.createProxyServer();

http.createServer(function (req, res) {
  // This simulates an operation that takes 500ms to execute
  setTimeout(function () {
    proxy.web(req, res, {
      target: 'http://target:80'
    });
  }, 500);
  console.log('request got:');
}).listen(7070);

proxy.on('proxyRes', function (proxyRes, req, res) {
  proxyRes.headers["x-10x-header"] = 'luke is the best';
  proxyRes.headers["access-control-allow-origin"] = '*';
  console.log(
    'RAW Response from the target',
    JSON.stringify(proxyRes.headers)
  );
});

 
