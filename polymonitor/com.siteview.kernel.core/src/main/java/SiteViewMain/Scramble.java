
package SiteViewMain;

import com.dragonflow.Utils.TextUtils;

import java.io.PrintStream;

public class Scramble
{

    public Scramble()
    {
    }

    public static void main(String args[])
    {
        if(args.length < 1)
        {
            System.out.println("Usage: Scramble cleartext");
            System.exit(0);
        }
        System.out.println(TextUtils.obscure(args[0]));
    }
}