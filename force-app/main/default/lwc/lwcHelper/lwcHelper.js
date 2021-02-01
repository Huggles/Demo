/**
 * Created by Hugo on 31/01/2021.
 */

const consoleLogAsJSON = (value)=>{
    console.log(JSON.stringify(value));
}
const consoleLogDeepCopy = (obj)=>{
    console.log(deepCloneObject(obj));
}
const deepCloneObject = (obj)=>{
    return JSON.parse(JSON.stringify(obj));
}


export { consoleLogAsJSON, consoleLogDeepCopy, deepCloneObject };