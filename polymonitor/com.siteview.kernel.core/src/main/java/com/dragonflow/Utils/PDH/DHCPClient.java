package com.dragonflow.Utils.PDH;

import java.util.Random;
import java.util.StringTokenizer;

import com.dragonflow.SiteView.Platform;
import edu.bucknell.net.JDHCP.DHCPMessage;
import edu.bucknell.net.JDHCP.DHCPSocket;
public class DHCPClient {
	public static final byte DHCP_BOOTREQUEST = 1;
	  public static final byte DHCP_HADDR_TYPE = 1;
	  public static final byte DHCP_HADDR_LEN = 6;
	  public static final byte DHCP_HOPS = 0;
	  public static final int DHCP_HWADDR_BUF_LEN = 16;
	  public static final int OP_REQUESTED_ID = 50;
	  public static final int OP_LEASE_TIME = 51;
	  public static final int OP_MESSAGE_TYPE = 53;
	  public static final int OP_SERVER_ID = 54;
	  public static final int OP_T1 = 58;
	  public static final int OP_T2 = 59;
	  private DHCPSocket socket;
//	  private static Log logger = LogFactory.getEasyLog(DHCPClient.class);
	  private String requestAddress;
//	  private DHCPMonitorResult result;

	  public DHCPClient(Object object) {
	}

	public static DHCPClient getInstance()
	  {
	    return InstanceHolder.instance;
	  }

	  public synchronized void acquireAddress(String requestAddress, String customMACAddress, String[] result, int leaseDuration, int maxTries, int sleepTime, boolean sendDHCPrequest)
	    throws  Exception
	  {
//	    this.result = result;

	    byte[] hwaddr = generateHwAddrFromStringMAC(customMACAddress);

	    this.requestAddress = requestAddress;

	    long startTime = System.currentTimeMillis();
	    try
	    {
//	      if (logger.isDebugEnabled()) {
	       System.out.println("Opening initial DHCPSocket");
//	      }

	      this.socket = new DHCPSocket(68);

//	      if (logger.isDebugEnabled()) {
	        System.out.println("DHCPSocket opened successfully");
//	      }

	      int releaseTime = -1;

	      DHCPMessage outMessage = new DHCPMessage();
	      DHCPMessage replyMessage = new DHCPMessage();
	      byte[] offeredAddr = new byte[4];
	      Random r = new Random();

	      outMessage.setChaddr(hwaddr);

	      int xid = r.nextInt();
	      if (requestAddress.length() > 0) {
//	        if (logger.isDebugEnabled()) {
	         System.out.println("Requesting Address " + requestAddress);
//	        }
	        outMessage.setOption(50, stringToIP(requestAddress));
	      }

	      initMessage(outMessage, xid, 1, leaseDuration);

	      for (int attempt = 1; attempt <= maxTries; ++attempt) {
//	        if (logger.isDebugEnabled()) {
	         System.out.println("Sending DHCPDISCOVER... ");
//	        }
	        this.socket.send(outMessage);
//	        if (logger.isDebugEnabled()) {
	          System.out.println("Sleeping " + sleepTime / maxTries + " seconds...");
//	        }

	        Platform.sleep(sleepTime / maxTries * 1000);

	        if ((this.socket.receive(replyMessage)) && 
	          (checkOffer(replyMessage, xid)))
	        {
	          offeredAddr = replyMessage.getYiaddr();
	          printAddr("yiaddr", "DHCPOFFER", offeredAddr);

	          break;
	        }

	        if (attempt != maxTries)
	          continue;
	        throw new Exception("Timed out waiting for DHCPOFFER");
	      }

	      String leasedAddress = ipToString(offeredAddr);

	      if (sendDHCPrequest)
	      {
	        releaseTime = 1;

	        outMessage.setOption(54, replyMessage.getOption(54));

	        byte[] renewalTimeOption = replyMessage.getOption(58);
	        if (renewalTimeOption != null) {
	          outMessage.setOption(58, renewalTimeOption);
	        }
	        byte[] rebindTimeOption = replyMessage.getOption(59);
	        if (rebindTimeOption != null) {
	          outMessage.setOption(59, rebindTimeOption);
	        }
	        outMessage.setOption(50, offeredAddr);

//	        if (logger.isDebugEnabled()) {
	         System.out.println("Sending DHCPREQUEST for address " + ipToString(offeredAddr) + "...");
//	        }

	        initMessage(outMessage, 3);
	        this.socket.send(outMessage);

	        if (!this.socket.receive(replyMessage)) {
//	          if (logger.isDebugEnabled()) {
	            System.out.println("Timed out waiting for DHCPACK");
//	          }
	          throw new Exception("Timed out waiting for DHCPACK");
	        }
	        if (replyMessage.getXid() != xid)
	        {
//	          if (logger.isDebugEnabled()) {
	            System.out.println("Received invalid DHCPACK from server (invalid xid)");
//	          }
	          throw new Exception("Received invalid DHCPACK from server");
	        }

//	        if (logger.isDebugEnabled()) {
	         System.out.println("Received address " + ipToString(replyMessage.getYiaddr()));
	          System.out.println("sending DHCPRELEASE in " + releaseTime + " seconds.");
//	        }
	        Platform.sleep(releaseTime * 1000);

	        outMessage.setCiaddr(offeredAddr);
	        outMessage.setOption(50, new byte[4]);
	        outMessage.setOption(51, new byte[4]);
	        outMessage.setOption(54, replyMessage.getOption(54));

//	        if (logger.isDebugEnabled()) {
	          System.out.println("Sending DHCPRELEASE for " + ipToString(replyMessage.getYiaddr()));
//	        }
	        outMessage.setXid(r.nextInt());

	        initMessage(outMessage, 7);
	        this.socket.send(outMessage);
	      }
	     result[2]="ok";
	     result[3]="leased address " + leasedAddress;
	     result[4]="leased address " + leasedAddress;
	    }
	    catch (Exception e)
	    {
	      long totalDuration;
	      String totalDurationString;
	      result[2]="Requested address unavailable";
	      result[3]=e.getMessage();
	      result[4]=e.getMessage();
	    }
	    finally
	    {
	      long totalDuration;
	      String totalDurationString;
	       totalDuration = System.currentTimeMillis() - startTime;

	      totalDurationString = new Long(totalDuration).toString();
	      result[0]=totalDurationString;
	      result[1]=totalDurationString;
//	      result.setMeasurement(totalDurationString);
//	      result.setRoundTripTime(totalDurationString);
//	      result.addStateString(TextUtils.floatToString((float)totalDuration / 1000.0F, 2) + " sec");
	      if (this.socket != null)
	        this.socket.close();
	    }
	  }

	  private void initMessage(DHCPMessage message, int xid, int type, int leaseDuration)
	  {
	    message.setOp((byte)1);
	    message.setHtype((byte)1);
	    message.setHlen((byte)6);
	    message.setHops((byte)0);
	    message.setXid(xid);
	    message.setSecs((byte)0);
	    byte[] initAddr = new byte[4];
	    for (int i = 0; i < 4; ++i) {
	      initAddr[i] = 0;
	    }
	    message.setCiaddr(initAddr);
	    message.setYiaddr(initAddr);
	    message.setSiaddr(initAddr);
	    message.setGiaddr(initAddr);

	    byte[] mtype = new byte[1];
	    mtype[0] = (byte)type;
	    message.setOption(53, mtype);
	    message.setOption(51, intToBytes(leaseDuration));
	    initMessage(message, type);
	  }

	  private void initMessage(DHCPMessage message, int type) {
	    if ((type == 1) || (type == 3)) {
//	      logger.debug("Setting the broadcast flag");
	      message.setFlags((short) -32768);
	    } else {
	      message.setFlags((short) 0);
	    }
	    byte[] mtype = new byte[1];
	    mtype[0] = (byte)type;
	    message.setOption(53, mtype);
	  }

	  private boolean checkOffer(DHCPMessage discoverReply, int xid)
	    throws Exception
	  {
	    byte[] replType = new byte[1];
	    replType = discoverReply.getOption(53);
	    if (replType[0] != 2) {
//	      if (logger.isDebugEnabled()) {
	        System.out.println("DHCP: message was not DHCPOFFER, retrying");
//	      }
	      return false;
	    }

	    if (discoverReply.getXid() != xid) {
//	      if (logger.isDebugEnabled()) {
	        System.out.println("DHCP: XIDs did not match, retrying");
//	      }
	      return false;
	    }

	    String offered = ipToString(discoverReply.getYiaddr());
	    String requested = this.requestAddress;
//	    if (logger.isDebugEnabled()) {
	      System.out.println("offered address " + offered);
//	    }

	    if ((this.requestAddress.length() > 0) && 
	      (!offered.equals(requested)))
	    {
	      throw new Exception("Requested address (" + this.requestAddress + ") unavailable");
	    }

	    return true;
	  }

	  private void printAddr(String field, String messageType, byte[] address) {
//	    if (logger.isDebugEnabled())
//	      logger.debug("*** " + field + " from " + messageType + ": " + ipToString(address));
	  }

	  private String ipToString(byte[] address)
	  {
	    String s = "";

	    for (int i = 0; i < 4; ++i) {
	      int current = (char)address[i] % 'Ā';
	      s = s + "" + current;
	      if (i < 3)
	        s = s + ".";
	    }
	    return s;
	  }

	  private byte[] stringToIP(String value) {
	    byte[] ip = new byte[4];
	    StringTokenizer st = new StringTokenizer(value, ".");

	    if (st.countTokens() != 4)
	      return ip;
	    for (int i = 0; i < 4; ++i) {
	      Integer val = new Integer(st.nextToken());
	      ip[i] = val.byteValue();
	    }

	    return ip;
	  }

	  private byte[] intToBytes(int value) {
	    int quotient = value;
	    byte[] b = new byte[4];

	    for (int i = 3; i > -1; --i) {
	      b[i] = (byte)((char)quotient % 'Ā');
	      quotient /= 256;
	    }

	    return b;
	  }

	  private byte[] generateHwAddr()
	  {
	    byte[] randomMACAddress = new byte[6];
	    new Random().nextBytes(randomMACAddress);
	    return hwAddrFromMac(randomMACAddress);
	  }

	  private byte[] generateHwAddrFromStringMAC(String customMACAddress) {
	    if ((customMACAddress == null) || (customMACAddress.equals("")))
	    {
	      return generateHwAddr();
	    }
	    try {
	      String cleanMAC = customMACAddress.replaceAll("[\\s:\\.\\-]", "");
	      Long customMACAddressLong = Long.valueOf(Long.parseLong(cleanMAC, 16));

	      if (cleanMAC.length() == 12) {
	        byte[] customMACAddressBytes = toByteArray(customMACAddressLong.longValue());
	        return hwAddrFromMac(customMACAddressBytes);
	      }
	      String err1 = "Custom MAC Address \"" + customMACAddress + "\" has incorect length. It should use " + 6 + " bytes. Default value will be used.";
	      System.out.println(err1);
//	      if (logger.isDebugEnabled()) {
//	        logger.debug(err1);
//	      }
	      return generateHwAddr();
	    }
	    catch (NumberFormatException e) {
	      String err2 = "Custom MAC Address \"" + customMACAddress + "\" contains non HEX characters. Default value will be used.";
	     System.out.println(err2);
//	      this.result.addStatusText(err2);
//	      if (logger.isDebugEnabled())
//	        logger.debug(err2, e);
	    }
	    return generateHwAddr();
	  }

	  private byte[] toByteArray(long data)
	  {
	    return new byte[] { (byte)(int)(data >> 56 & 0xFF), (byte)(int)(data >> 48 & 0xFF), (byte)(int)(data >> 40 & 0xFF), (byte)(int)(data >> 32 & 0xFF), (byte)(int)(data >> 24 & 0xFF), (byte)(int)(data >> 16 & 0xFF), (byte)(int)(data >> 8 & 0xFF), (byte)(int)(data >> 0 & 0xFF) };
	  }

	  private byte[] hwAddrFromMac(byte[] MACAddr)
	  {
	    byte[] hwaddr = new byte[16];
	    if (MACAddr == null) {
//	      if (logger.isDebugEnabled()) {
	       System.out.println("MAC address array is null.");
//	      }
	      return hwaddr;
	    }
	    int macLen = MACAddr.length;

	    if ((macLen > 0) && (macLen <= 16)) {
	      int srcStartPos = (macLen >= 6) ? macLen - 6 : 0;
	      int destLen = macLen - srcStartPos;
	      System.arraycopy(MACAddr, srcStartPos, hwaddr, 0, destLen);
	    } 
	    return hwaddr;
	  }

	  private static class InstanceHolder
	  {
	    private static final DHCPClient instance = new DHCPClient(null);
	  }
	  public static void main(String[] args) throws Exception {
		  DHCPClient.getInstance().acquireAddress("192.168.1.10", "00E06682B1BA", null, 1, 10, 6, true);
	}
}
