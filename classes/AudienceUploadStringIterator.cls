public class AudienceUploadStringIterator implements Iterator<String>, Iterable<String>
{
    private String i_fileData;
    private Integer i_index = 0;
    private String i_rowDelimiter = '\n';
    
    public AudienceUploadStringIterator(String fileData, String rowDelimiter)
    {
        i_fileData = fileData;
        i_rowDelimiter = String.isNotBlank(rowDelimiter) ? rowDelimiter : i_rowDelimiter;
    }
    
    public Boolean hasNext()
    {
        return i_index < i_fileData.length() ? true : false;
    }
    
    public String next()
    {
        Integer key = i_fileData.indexOf(i_rowDelimiter, i_index);
        
        if (key == -1)
            key = i_fileData.length();
            
        String row = i_fileData.subString(i_index, key);
        i_index = key + 1;
        return row;
    }
    
    public Iterator<String> Iterator()
    {
        return this;
    }
}