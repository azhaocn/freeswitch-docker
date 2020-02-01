#!/usr/bin/env lua
local sipid=argv[1];
local uuid=argv[2];
local http=require("socket.http");
local ltn12 = require("ltn12");

local request_body = sipid.."/"..uuid..".wav"
local response_body = {}

local res, code, response_headers = http.request{
    url = "http://127.0.0.1:8080/work",
    method = "POST",
    headers =
    {
        ["Content-Type"] = "application/x-www-form-urlencoded";
        ["Content-Length"] = #request_body;
    },
    source = ltn12.source.string(request_body),
    sink = ltn12.sink.table(response_body),
}

freeswitch.console_log("info","response code:"..code)
if type(response_body) == "table" then
    freeswitch.console_log("info",table.concat(response_body))
else
    freeswitch.console_log("info","Not a table:"..type(response_body))
end
