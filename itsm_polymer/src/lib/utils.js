var Utils = {

  makeUUID() {
    return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, function(a, b) {
      return b = Math.random() * 16, (a == "y" ? b & 3 | 8 : b | 0).toString(16)
    })
  },

  makeRecID() {
    return "xxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx".replace(/[xy]/g, function(a, b) {
      return b = Math.random() * 16, (a == "y" ? b & 3 | 8 : b | 0).toString(16).toUpperCase()
    })
  },

  validateIp(ip) {
    var pattern = /(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)/;
    return pattern.test(ip);
  },

  loadXMLString(txt) {
    var xmlDoc;
    var parser;
    if (window.DOMParser) {
      parser = new DOMParser();
      xmlDoc = parser.parseFromString(txt, "text/xml");
    } else { // Internet Explorer
      xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
      xmlDoc.async = "false";
      xmlDoc.loadXML(txt);
    }
    return xmlDoc;
  },

  firstUpperCase(str) {
    return str.replace(/^\S/,function(s){return s.toUpperCase();});
  },
}
