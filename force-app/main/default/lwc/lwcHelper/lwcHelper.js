/**
 * Created by Hugo on 31/01/2021.
 */

const consoleLogAsJSON = (value)=>{
    console.log(JSON.stringify(value));
}
const consoleLogDeepCopy = (obj)=>{
    console.log(JSON.stringify(obj));
}
const deepCloneObject = (obj)=>{
    console.log(JSON.parse(JSON.stringify(obj)));
}


export { consoleLogAsJSON, consoleLogDeepCopy, deepCloneObject };