/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package MandE;

import javax.microedition.midlet.*;
import javax.microedition.lcdui.*;

import javax.wireless.messaging.MessageConnection;
import javax.wireless.messaging.TextMessage;
import javax.microedition.io.Connector;
/**
 * @author James
 */
public class OperationsMidlet extends MIDlet implements CommandListener {

    //Here an creating an instance of the display manager for the application
    Display display;
    int displayedComp;

    List operationsOption;//done
    Form requestPage;//done
    Form dietPage; // done
    Form reports;
    Form login;// done
    Form statusPage;//next call of duty
    Form setupPage;// done
    Form infoPage; //done

    //Here will be many textboxes to be used throughout the application
    //For the login the following are the Items that will be added
    StringItem commandLabel;
    TextField username;
    TextField password;

    //Here we create components that will be useful for the status page
    //The following are the items needed
    TextField bloodPressure;
    TextField weight;
    TextField sugarLevel;
    TextField remarks;

    //Here we create components that will be useful for the setup page
    //The following are the items needed
    TextField usernSetup;
    TextField passSetup;
    TextField rpassSetup;
    TextField numToSend;

    //Here we create components that will be useful for the request page
    //The following are the items needed
    TextBox requestBox;

    //Here we create components that will be useful for the info page
    //The following are the items needed
    StringItem appInfo;

    //Here we create components that will be useful for the dietary intake page
    //The following are the items needed
    TextField carbonhydrateIntake;
    TextField proteinIntake;
    TextField waterIntake;
    TextField fruitsIntake;
    TextField fatsIntake;
    ChoiceGroup exercise;
    TextField exDuration;

    //It is important to have the SMS message composed on the fly
    //Based on each method(dietary intake, request, setup, diet page) that can assign a payload, the payload will be compiled at method runtime
    String smsMessage;

    // The following are the list of commands to be used within the application
    private static final Command loginCommand = new Command("Login", Command.OK, 4);
    private static final Command exitCommand = new Command ("Exit", Command.EXIT, 7);
    private static final Command menuCommand = new Command ("Back", Command.BACK, 2);
    private static final Command saveCommand = new Command ("Save", Command.SCREEN, 1);
    private static final Command sendSMS = new Command("Send", Command.OK, 4);// For initiating the send sms action

    public OperationsMidlet()
    {
        //This will be used for eagerly loading resources that will be used in the application
        //Such as the SMS factory
    }

    public void startApp() 
    {
        display = Display.getDisplay(this);
        //loginAction();

        mainMenu();
    }

    private void mainMenu()
    {
        display = Display.getDisplay(this);
        operationsOption = new List("Select M & E task", Choice.IMPLICIT);
        operationsOption.append("Daily Status", null);
        operationsOption.append("Dietary intake", null);
        operationsOption.append("Reports", null);
        operationsOption.append("Special requests", null);
        operationsOption.append("Setup", null);
        operationsOption.append("Information", null);

        operationsOption.addCommand(exitCommand);
        operationsOption.setCommandListener(this);

        display.setCurrent(operationsOption);

        //currentMenu = "Main";
    }

    private void loginAction()
    {
      username = new TextField("Username", "", 15, TextField.ANY);
      password = new TextField("Password", "", 15, TextField.PASSWORD);
      commandLabel = new StringItem( "","Monitoring and Evaluation System" );
      login = new Form("Login");

      login.append(commandLabel);
      login.append(username);
      login.append(password);

      login.addCommand(exitCommand);
      login.addCommand(loginCommand);
      login.setCommandListener(this);

      display.setCurrent(login);
    }

    public void pauseApp() {
        //It will be necessary to release all the resources being used by the VM
        //since resources are constrained on this type of device
    }

    public void destroyApp(boolean unconditional)
    {
            notifyDestroyed();
    }

    /*
     *Handle events.
     **/
    public void commandAction(Command c, Displayable d)
    {
        String label = c.getLabel();
        if(label.equals("Exit"))
        {
            destroyApp(true);
        }
        else if(label.equals("Login"))
        {
            String userCheck = username.getString();
            String passwordCheck = password.getString();
            if(userCheck.equalsIgnoreCase("admin") && passwordCheck.equalsIgnoreCase("admin"))
            {
                mainMenu();
            }
            else
            {
                alertAction("Wrong ID","Enter ID again",1);
            }
        }
        else if(label.equals("Back"))
        {
            mainMenu();
        }
        else if(label.equals("Save"))
        {
            alertAction("Setup changed", "Profile Data has been saved!", 2);
        }
        
        else if(label.equals("Send"))
        {
            //Here we need to implement a very rigorous algorithm to check the formatting of the content of the text message being sent
            //Open the message connection factory so that the accompanying text can be sent with the in-built mobile number that
            //will be obtainable from the available menu option

            //It will be necessary to call factory functions to post the message
            //to the SMS gateway address.

            //postMessage(); // get the displayable and all the items within each component
            // a global status int might be necessary to message type posting easier

            alertAction("Success!", "Data has been sent",2);
            
            postSMS();
        }
        else
        {
            List down = (List)display.getCurrent();
            switch(down.getSelectedIndex())
            {
                case 0: dailyStatusLoad(); break;// done
                case 1: intakePageLoad(); break; //done
                case 2: reportPageLoad(); break;
                case 3: requestPageLoad(); break; //done
                case 4: setupPageLoad(); break;// done
                case 5: infoPageLoad(); break; // done
            }
        }
    }

    private void alertAction(String header, String message, int valueType)
    {
        final Alert wrongInfo = new Alert(header);
        if(valueType == 1)
        {
            wrongInfo.setType(AlertType.ERROR);
        } 

        //soundAlert.setTimeout(20);
        wrongInfo.setString(message);
        display.setCurrent(wrongInfo);
    }

    /*It is necessary to dynamically concatenate the the string variable which is being
     * generated on each page,
     * However, the constraints being that the pages do not have sent number and type of items
     * thus, a variable String argument method will be called to set the value for the
     * sms message being used in the application
     * However, it is important we dileneate when this method is called, because we are dealing with a
     * resource contrained device.
     *
     * Sadly, variable arguments are not supported in source 1.3 only in source 1.5, whatever that means I wish to God I understand
     */
    /*private void stringConcatenator(String ... contents)
    {

    }*/

    /*
     * * I will just opt for generating the String on the fly
     */

    private void dailyStatusLoad()
    {
        display = Display.getDisplay(this);
        statusPage = new Form("Monitoring result");

        bloodPressure = new TextField("Blood Pressure", "", 15, TextField.NUMERIC);
        weight = new TextField("Weight", "", 15, TextField.NUMERIC);
        sugarLevel = new TextField("Sugar Level", "", 15, TextField.NUMERIC);
        remarks = new TextField ("Remark", "", 15, TextField.ANY);

        statusPage.append(bloodPressure);
        statusPage.append(weight);
        statusPage.append(sugarLevel);
        statusPage.append(remarks);

        displayedComp = 1;

        statusPage.addCommand(menuCommand);
        statusPage.addCommand(sendSMS);
        statusPage.setCommandListener(this);

        display.setCurrent(statusPage);
    }
    private void intakePageLoad()
    {
        String[] exerciseType = {"Road walk", "Jogging", "Pushups", "Hamstring", "Body squatting", "Judo pressup", "Pullups"};

        display = Display.getDisplay(this);        
        dietPage = new Form("Dietary intake page");

        carbonhydrateIntake = new TextField("Carbonhydrate(cal)", "", 15, TextField.NUMERIC);
        proteinIntake = new TextField("Protein(gms)", "", 15, TextField.NUMERIC);
        waterIntake = new TextField("Water(Li)", "", 15, TextField.NUMERIC);
        fruitsIntake = new TextField("Fruits(gms)", "", 15, TextField.NUMERIC);
        fatsIntake = new TextField("Fats & Oil(gms)", "", 15, TextField.NUMERIC);
        exercise = new ChoiceGroup("Exercise type:", ChoiceGroup.POPUP, exerciseType, null);
        exDuration = new TextField("Duration(min)", "", 15, TextField.NUMERIC);

        displayedComp = 2;

        dietPage.append(carbonhydrateIntake);
        dietPage.append(proteinIntake);
        dietPage.append(waterIntake);
        dietPage.append(fruitsIntake);
        dietPage.append(fatsIntake);
        dietPage.append(exercise);
        dietPage.append(exDuration);

        dietPage.addCommand(menuCommand);
        dietPage.addCommand(sendSMS);
        dietPage.setCommandListener(this);

        display.setCurrent(dietPage);
    }
    private void reportPageLoad()
    {
        /*display = Display.getDisplay(this);
        //requestPage = new Form("Special request");
        requestBox = new TextBox("Type Special request:", "", 100, TextField.ANY);

        requestBox.addCommand(menuCommand);
        requestBox.addCommand(sendSMS);
        requestBox.setCommandListener(this);

        display.setCurrent(requestBox);*/
    }

    private void requestPageLoad()
    {       
        display = Display.getDisplay(this);        
        requestBox = new TextBox("Type Special request:", "", 100, TextField.ANY);

        displayedComp = 3;

        requestBox.addCommand(menuCommand);
        requestBox.addCommand(sendSMS);
        requestBox.setCommandListener(this);

        display.setCurrent(requestBox);
    }
    private void setupPageLoad()
    {
        display = Display.getDisplay(this);
        setupPage = new Form("Application Setup");
        
        usernSetup = new TextField("Username", "", 15, TextField.ANY);
        passSetup = new TextField("Password", "", 15, TextField.PASSWORD);
        rpassSetup = new TextField("Re-type Password", "", 15, TextField.PASSWORD);
        numToSend = new TextField("Gateway's number", "", 15, TextField.NUMERIC);

        setupPage.append(usernSetup);
        setupPage.append(passSetup);
        setupPage.append(rpassSetup);
        setupPage.append(numToSend);

        setupPage.addCommand(menuCommand);
        setupPage.addCommand(saveCommand);
        setupPage.setCommandListener(this);

        display.setCurrent(setupPage);
    }
    private void infoPageLoad()
    {
        display = Display.getDisplay(this);
        infoPage = new Form("App information");
        
        appInfo = new StringItem("", "This mobile application is develop to aid the process of monitoring and evaluation. Data are transferred through SMS based on user input. This is a alpha version v1.0.1. Any special application request can be sent to the developers on the request page.  Thanks");
        infoPage.append(appInfo);

        infoPage.addCommand(menuCommand);
        infoPage.setCommandListener(this);

        display.setCurrent(infoPage);
    }

    private void postSMS()
    {
        try
        {
            MessageConnection conn;
            String gatewayNum = numToSend.getString().trim();
            String message = attachPayload();

            if(gatewayNum.length() == 11)
            {
                conn = (MessageConnection)Connector.open("sms://" + gatewayNum);
            }
            else
            {
                conn = (MessageConnection)Connector.open("sms://" + "07038979082");
            }

            TextMessage txtMsg = (TextMessage)conn.newMessage(MessageConnection.TEXT_MESSAGE);
            txtMsg.setPayloadText(message);
            conn.send(txtMsg);
            conn.close();            
        }
        catch(Exception ex)
        {
            //alertAction("Error",ex.toString(),2);
        }
    }

    private String attachPayload()
    {
        try
        {
            switch(displayedComp)
            {
                case 1:
                    smsMessage = bloodPressure.getString().concat(" ").concat(weight.getString().concat(" ").concat(sugarLevel.getString().concat(" ").concat(remarks.getString())));
                    break;
                case 2:
                    smsMessage = carbonhydrateIntake.getString().concat(" ").concat(proteinIntake.getString().concat(" ").concat(waterIntake.getString().concat(" ").concat(fruitsIntake.getString().concat(" ").concat(fatsIntake.getString().concat(" ").concat(exercise.getString(exercise.getSelectedIndex()).concat(" ").concat(exDuration.getString()))))));
                    break;
                case 3:
                    smsMessage = requestBox .getString();
                    break;
            }

        }
        catch (NullPointerException ex)
        {
            smsMessage = "Hello Sdg, M & E is the future!";
        }

        return smsMessage;
    }
}
