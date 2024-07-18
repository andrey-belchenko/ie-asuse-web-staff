import fetch from "node-fetch";
import xml2js from "xml2js";
const serviceUrl = process.env.adp_kisur_file_service_url;
const login = process.env.adp_kisur_file_service_login;
const password = process.env.adp_kisur_file_service_password;
const endpointUrl =
  serviceUrl +
  "/sap/bc/srt/rfc/sap/zpm_send_tplnr_file_by_id/700/zpm_send_tplnr_file_by_id/zpm_send_tplnr_file_by_id";
function extractBase64(xmlResponse: string): Promise<string> {
  return new Promise((resolve, reject) => {
    const parser = new xml2js.Parser();
    let decodedFile = "";

    parser.parseString(xmlResponse, (err, result) => {
      if (err) {
        reject(err);
      } else {
        decodedFile =
          result["soap-env:Envelope"]["soap-env:Body"][0][
            "n0:ZPM_SEND_TPLNR_FILE_BY_IDResponse"
          ][0]["ET_CONTENT"][0];
        resolve(decodedFile);
      }
    });
  });
}
export const getFileData = async (id: string) => {
  process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";
  const buf = Buffer.from(`${login}:${password}`, "utf8");
  const credsBase64 = buf.toString("base64");
  const options = {
    method: "POST",
    headers: {
      "Content-Type": "text/xml; charset=utf-8",
      SOAPAction:
        "urn:sap-com:document:sap:rfc:functions:ZPM_SEND_TPLNR_FILE_BY_ID:ZPM_SEND_TPLNR_FILE_BY_IDRequest",
      Authorization: "Basic " + credsBase64,
      Cookie: "sap-usercontext=sap-client=700",
    },
    body:
      '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">\n   <soapenv:Header/>\n   <soapenv:Body>\n      <urn:ZPM_SEND_TPLNR_FILE_BY_ID>\n         <I_PH_OBJID>' +
      id +
      "</I_PH_OBJID>\n      </urn:ZPM_SEND_TPLNR_FILE_BY_ID>\n   </soapenv:Body>\n</soapenv:Envelope>",
  };

  // "http://cirtd.mrsk-1.ru:8074/sap/bc/srt/rfc/sap/zpm_send_tplnr_file_by_id/700/zpm_send_tplnr_file_by_id/zpm_send_tplnr_file_by_id",
  const response = await fetch(endpointUrl, options);
  const data = await response.text();
  const base64Str = await extractBase64(data);
  return Buffer.from(base64Str, "base64");
};
