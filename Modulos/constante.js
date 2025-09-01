export const magicNumber = 42; // ejemplo de constante que se puede exportar a otros archivos
//export let number = 42;
//export const hello = () =>  "Hello World";
//export class CodeBlock { };
let number = 42;
const hello = () => "¡Hello";
const goodbye = () => "¡Adiós!";
class CodeBlock { };

export {number};
export {hello, goodbye as bye};
export {CodeBlock};
export default "SENA"