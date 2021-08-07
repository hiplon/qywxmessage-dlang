import std.stdio;
import std.net.curl;
import std.string;
import std.json;

void main()
{
	string sendmessage = "😆😆😘😎😘😘";
	writeln(sendpack(sendmessage));

}

string sendpack(string message){

	string corp_id = "wwc27f8c25bf0b362a"; // Your corp_id
	string app_secret = "T2-GWs9vxvgA2TttdTE27-Fm1CDQ8YDubGLu93qAqcU"; // Your app_secret
	string app_id = "1000004"; // Your app_id
    // Let's get going!
	
	string qxgeturl = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=" ~ corp_id ~ "&corpsecret=" ~ app_secret;
	//writeln("waiting");
    auto qxgetcontent = get(qxgeturl);
	
	JSONValue qxgetobj = parseJSON(qxgetcontent);

	JSONValue innderMsg = [ "content": message ];
	
	JSONValue postpack = [ "agentid": app_id ];
	postpack.object["touser"] = JSONValue("@all");
	postpack.object["msgtype"] = JSONValue("text");
	postpack.object["safe"] = JSONValue(0);
	postpack.object["text"] = innderMsg;
	
	string getsring = qxgetobj["access_token"].str;
	
	string qxposturl = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=" ~ getsring;
	
	auto postrsp = post(qxposturl, postpack.toString);
	
	return parseJSON(postrsp).toString;
	
}