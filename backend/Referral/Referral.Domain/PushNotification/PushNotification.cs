using System;
using System.IO;
using System.Net;
using System.Text;
using Newtonsoft.Json;

namespace Referral.Domain.PushNotification
{
    public class PushNotification
    {
       public void Notify(String token, String title, String body)
        {
            try
            {    
                var serverKey = "AAAAdJuXC70:APA91bHEOvOQParXoU--CuB29fhioexFZrE_YxH-2ZrGbl9CO_Eqs6eRL_gByra-K8gBx1bFoH9QWS98419xBRJK5qMVY9f1dBsphIZjmsz2c_RrC2d_wtd2ycbknuAWAnpJ5NV9LxHM";

                var senderId = "500826573757";

                //string deviceId = "euxqdp------ioIdL87abVL";

                WebRequest tRequest = WebRequest.Create("https://fcm.googleapis.com/fcm/send");

                tRequest.Method = "post";

                tRequest.ContentType = "application/json";

                var data = new

                {

                    to = token,

                    notification = new

                    {

                        body = body,

                        title = title,


                    }    
                };       

                //var serializer = new JavaScriptSerializer();

                //var json = serializer.Serialize(data);
                var json = JsonConvert.SerializeObject(data);

                Byte[] byteArray = Encoding.UTF8.GetBytes(json);

                tRequest.Headers.Add(string.Format("Authorization: key={0}", serverKey));

                tRequest.Headers.Add(string.Format("Sender: id={0}", senderId));

                tRequest.ContentLength = byteArray.Length; 


                using (Stream dataStream = tRequest.GetRequestStream())
                {

                    dataStream.Write(byteArray, 0, byteArray.Length);   


                    using (WebResponse tResponse = tRequest.GetResponse())
                    {

                        using (Stream dataStreamResponse = tResponse.GetResponseStream())
                        {

                            using (StreamReader tReader = new StreamReader(dataStreamResponse))
                            {

                                String sResponseFromServer = tReader.ReadToEnd();

                                string str = sResponseFromServer;

                            }    
                        }    
                    }    
                }    
            }        

            catch (Exception ex)
            {

                string str = ex.Message;

            }          

        }    
    }
}