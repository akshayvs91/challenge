def get_value(nestedObj, keysList):    
    try:
        for key in keysList:
            nestedObj = nestedObj[key]
        print("Value is: ")
        return nestedObj
    except KeyError:
         print("Could not find a match")
