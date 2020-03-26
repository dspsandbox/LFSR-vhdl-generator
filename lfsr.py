#############################################
# LFSR pseudorandom number generator
# Pau Gomez (c) pau.gomez@dspsandbox.org
#############################################

def generate_xorList(lfsrLen,tapList,lfsrIter):
    xorList=[]
    for i in range(0,lfsrLen):
        xorList=xorList+[[i]]

    for i in range(0,lfsrIter):
        newEntry=[]
        for j in tapList:         
            newEntry+=xorList[j]
        newEntryParsed=[]

        for j in range(0,lfsrLen):
            if newEntry.count(j)%2:
                newEntryParsed+=[j]

        for j in range(1,lfsrLen):
            xorList[lfsrLen-j]=xorList[lfsrLen-j-1]
        xorList[0]=newEntryParsed

    return xorList

def generate_vhdl(lfsrLen,tapList,lfsrIter,templatePath,outputPath):
    xorList=generate_xorList(lfsrLen,tapList,lfsrIter)

    f=open(templatePath,"rb")
    txt=(f.read()).decode()
    f.close()

    txt=txt.replace("<lfsrLen>",str(lfsrLen))
    txt=txt.replace("<tapList>",str(tapList))
    txt=txt.replace("<lfsrIter>",str(lfsrIter))

    xorListTxt=""
    for i in range(0,lfsrLen):
        xorListTxt+="sr(%i) <= "%i
        for j in range(0,len(xorList[i])-1):
            xorListTxt+="sr(%i)"%xorList[i][j]
            xorListTxt+=" xor "
        xorListTxt+="sr(%i)"%xorList[i][-1]
        xorListTxt+=";\n"  

    txt=txt.replace("<xorList>",str(xorListTxt)) 
    f=open(outputPath,"wb+")
    f.write(txt.encode())
    f.close()

    return



if __name__ == "__main__":
    # Example (I)
    lfsrLen=8
    tapList=[7,6,5,4]
    lfsrIter=1
    templatePath="lfsr_template.vhd"
    outputPath="Examples/lfsr_8Bit_1Iter.vhd"
    generate_vhdl(lfsrLen,tapList,lfsrIter,templatePath,outputPath)

    # Example (II)
    lfsrLen=8
    tapList=[7,6,5,4]
    lfsrIter=8
    templatePath="lfsr_template.vhd"
    outputPath="Examples/lfsr_8Bit_8Iter.vhd"
    generate_vhdl(lfsrLen,tapList,lfsrIter,templatePath,outputPath)