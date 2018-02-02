@isTest
public class AudienceUploadStringIterator_Test 
{
    @isTest
    public static void testMethod001()
    {
        String testString = '12345,83782,320934,3029834';
        String testRowDelimiter = '\n';
        
        AudienceUploadStringIterator ausi = new AudienceUploadStringIterator(testString, testRowDelimiter);
        Boolean testHasNext = ausi.hasNext();
        String nextString = ausi.next();
        Iterator<String> testIterator = ausi.Iterator();
    }
}