from flask import Flask , request , jsonify 
from bs4 import BeautifulSoup 
import requests  
import re  
app = Flask(_name_) 
@app.route('/api/v1/',methods=['GET'])  
def API():  
    if request.method == 'GET':
        data=str(request.args['query'])[1:-1] 
l=re.findall("\[(.*?)\]", data) 
newCoordinates=[] 
for i in range(len(l)): 
    newCoordinates.append([int(j) for j in l[i].split(',')]) 
source,destination=newCoordinates[-1] 
newCoordinates=newCoordinates[:-1]  
def findPath(src,dest,bestPath,visited,optimalPaths): 
    for i in bestPath:  
        x,y=i.split('->')  
        if(int(x)==src): 
            if(int(y)!=dest and int(y) not in visited):  
                findPath(int(y),dest,bestPath,visited+[src],optimalPaths)  
                #print(currentPath,visited,src,dest)  
            elif(int(y)==dest):  
                #print(visited)  
                optimalPaths.append(visited+[src,dest]) 
            return optimalPaths 
    bestPath=[]  
    for i in range(len(newCoordinates)-1):  
        for j in range(i+1,len(newCoordinates)):  
            x,y=newCoordinates[i] 
            a,b=newCoordinates[j]  
            if(x==a or y==b): 
                bestPath.append(f'{i}->{j}')  
    optimalPaths=[]  
    checkPoints=len(newCoordinates)  
    for i in range(checkPoints-1): 
        for j in range(i+1,checkPoints):  
            allPaths=findPath(i,j,bestPath,[],[]) 
            #src,dest,bestPath,visited  
            if(len(allPaths)!=0) 
                optimalPaths.append({points:[i,j],path:min(allPaths,key=lambda x:len(x))}) 
                print() 
    for i in optimalPaths: 
        print(i)  
        print(newCoordinates) 
    return jsonify(optimalPaths)  

if _name_ == '_main_': 
    app.run() 
    from flask import Flask , request , jsonify 
    from bs4 import BeautifulSoup  
    import requests  
    import re app = Flask(_name_)  
    @app.route('/api/v1/',methods=['GET']) 
