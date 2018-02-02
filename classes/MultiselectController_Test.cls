@istest
public class MultiselectController_Test{
 public static testmethod void Multiselect(){
 List<SelectOption> leftOptions1 =new SelectOption[3];
 List<SelectOption> rightOptions1 =new SelectOption[3];
 String hide;
 hide='option';

  MultiselectController Multi = new MultiselectController();
   Multi.leftOptions = leftOptions1;
   Multi.rightOptions = rightOptions1;
   Multi.leftOptionsHidden =hide;
   Multi.rightOptionsHidden =hide;
  }
}