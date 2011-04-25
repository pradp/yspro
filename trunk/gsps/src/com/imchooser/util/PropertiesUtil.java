package com.imchooser.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.StringTokenizer;

public class PropertiesUtil {

	private Properties properties ;
	
	public Properties getProperties() {
		return properties;
	}
	public void setProperties(Properties properties) {
		this.properties = properties;
	}
	
	public PropertiesUtil(String propertyFile) throws IOException{
		this.properties = createFromFile(propertyFile);
	}
	
	public void setProperty(String key,String value){
		
		properties.setProperty(key, value);
	}
	
	public String getProperty(String key){
		
		return properties.getProperty(key);
	}

	public String getProperty(String key, String defaultValue){
		
		return properties.getProperty(key, defaultValue);
	}
	
	public void removeProperty(String key){
		
		properties.remove(key);
	}
	
	public static Properties createFromFile(String fileName) throws IOException {
		return createFromFile(new File(fileName));
	}
	public static Properties createFromFile(File file) throws IOException {
		Properties prop = new Properties();
		loadFromFile(prop, file);
		return prop;
	}
	public static void loadFromFile(Properties p, String fileName) throws IOException {
		loadFromFile(p, new File(fileName));
	}
	public static void loadFromFile(Properties p, File file) throws IOException {
		if (p == null) {
			return;
		}
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(file);
			p.load(fis);
		} finally {
			if (fis != null) {
				fis.close();
			}
		}
	}


    /**
     * @param property The property you want to retrieve
     * @param properties The properties object you want to read it from.
     * @return Returns the boolean value of the propeties.
     */
    public static boolean getBoolean(String property, Properties properties) {
        return Boolean.valueOf(properties.getProperty(property)).booleanValue();
    }

    /**
     * @param property The property you want to retrieve
     * @param properties The properties object you want to read it from.
     * @param defaultValue The value to default.
     * @return Returns the boolean value, if null return the defaultValue.
     */
    public static boolean getBoolean(String property, Properties properties, boolean defaultValue) {
        String setting = properties.getProperty(property);
        return (setting==null) ? defaultValue : Boolean.valueOf(setting).booleanValue();
    }
    
    /**
     * @param property The property you want to retrieve
     * @param properties The properties object you want to read it from.
     * @param defaultValue The value to default.
     * @return Returns the boolean value, if null return the defaultValue.
     */
    public static int getInt(String property, Properties properties, int defaultValue) {
        String propValue = properties.getProperty(property);
        return (propValue==null) ? defaultValue : Integer.parseInt(propValue);
    }
    
    /**
     * @param property The property you want to retrieve
     * @param properties The properties object you want to read it from.
     * @param defaultValue The value to default.
     * @return Returns the String value, if null return the defaultValue.
     */
    public static String getString(String property, Properties properties, String defaultValue) {
        String propValue = properties.getProperty(property);
        return (propValue==null) ? defaultValue : propValue;
    }

    /**
     * @param property The property you want to retrieve
     * @param properties The properties object you want to read it from.
     * @return Returns the Integer value.
     */
    public static Integer getInteger(String property, Properties properties) {
        String propValue = properties.getProperty(property);
        return (propValue==null) ? null : Integer.valueOf(propValue);
    }

    /**
     * @param property The property to retrieve.
     * @param delim The delim.
     * @param properties The properties object.
     * @return Returns a Map of the properties values.
     */
    @SuppressWarnings("unchecked")
	public static Map toMap(String property, String delim, Properties properties) {
        Map map = new HashMap();
        String propValue = properties.getProperty(property);
        if (propValue!=null) {
            StringTokenizer tokens = new StringTokenizer(propValue, delim);
            while ( tokens.hasMoreTokens() ) {
                map.put(
                		tokens.nextToken(),
                		tokens.hasMoreElements() ? tokens.nextToken() : ""
                		);
            }
        }
        return map;
    }
    
    /**
     * replace a property by a starred version
     * 
     * @param props properties to check
     * @param key proeprty to mask
     * @return cloned and masked properties
     */
    public static Properties maskOut(Properties props, String key) {
        Properties clone = (Properties) props.clone();
        if (clone.get(key) != null) {
            clone.setProperty(key, "****");
        }
        return clone;
    }

}
