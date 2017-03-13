package jsweet.dom;
/** <p>The <strong>WebGLProgram</strong> is part of the WebGL API and is a combination of two compiled <code>WebGLShader</code>s consisting of a vertex shader and a fragment shader (both written in GLSL). These are then linked into a usable program.</p> <pre>var program = gl.createProgram();

// Attach pre-existing shaders
gl.attachShader(program, vertexShader);
gl.attachShader(program, fragmentShader);

gl.linkProgram(program);

if ( !gl.getProgramParameter( program, gl.LINK_STATUS) ) {
  var info = gl.getProgramInfoLog(program);
  throw &quot;Could not compile WebGL program. \n\n&quot; + info;
}
</pre> <p>See <code>WebGLShader</code> for information on creating the <code>vertexShader</code> and <code>fragmentShader</code> in the above example.</p>  */
public class WebGLProgram extends WebGLObject {
    public static WebGLProgram prototype;
    public WebGLProgram(){}
}

