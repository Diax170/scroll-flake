## wayland\.windowManager\.scroll\.enable



Whether to enable scroll wayland compositor\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.package



scroll package to use\. Will override the options
‘wrapperFeatures’, ‘extraSessionCommands’, and ‘extraOptions’\.
Set to ` null ` to not add any scroll package to your
path\. This should be done if you want to use the NixOS scroll
module to install scroll\. Beware setting to ` null ` will also disable
reloading scroll when new config is activated\.



*Type:*
null or package



*Default:*

```nix
<derivation sway-1.12>
```



## wayland\.windowManager\.scroll\.checkConfig

If enabled, validates the generated config file\.



*Type:*
boolean



*Default:*

```nix
wayland.windowManager.scroll.package != null
```



## wayland\.windowManager\.scroll\.config



scroll configuration options\.



*Type:*
null or (submodule)



*Default:*

```nix
{ }
```



## wayland\.windowManager\.scroll\.config\.animations



Configure Scroll animations\. See ` scroll(5) ` for more details\.



*Type:*
submodule



*Default:*

```nix
{ }
```



## wayland\.windowManager\.scroll\.config\.animations\.enable



Whether to enable animations\.



*Type:*
boolean



*Default:*

```nix
true
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.default



The default animation, also used as a fallback\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 300;
  enable = true;
  var = {
    controlPoints = [
      0.215
      0.61
      0.355
      1
    ];
    order = 3;
  };
}
```



## wayland\.windowManager\.scroll\.config\.animations\.default\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.default\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.default\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.default\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.default\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.default\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.default\.var\.order



Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeIn



Curve to use while a window is being opened for fade in animation\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 300;
  enable = true;
  var = {
    controlPoints = [
      0.32
      0
      0.67
      0
    ];
    order = "simple";
  };
}
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeIn\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeIn\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeIn\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeIn\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeIn\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeIn\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeIn\.var\.order



Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeOut



Curve to use while a window is being closed for fade out animation\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 300;
  enable = true;
  var = {
    controlPoints = [
      0.33
      1
      0.68
      1
    ];
    order = "simple";
  };
}
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeOut\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeOut\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeOut\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeOut\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeOut\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeOut\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.fadeOut\.var\.order



Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.jump



Animation curve to use while entering/leaving the jump mode\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 500;
  enable = true;
  var = {
    controlPoints = [
      0.215
      0.61
      0.355
      1
    ];
    order = "simple";
  };
}
```



## wayland\.windowManager\.scroll\.config\.animations\.jump\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.jump\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.jump\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.jump\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.jump\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.jump\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.jump\.var\.order



Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.layerShell



Animation curve to use for the layer shell (like bars or menus)\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 300;
  enable = true;
  var = {
    controlPoints = [
      0
      0
      1
      1
    ];
    order = "simple";
  };
}
```



## wayland\.windowManager\.scroll\.config\.animations\.layerShell\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.layerShell\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.layerShell\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.layerShell\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.layerShell\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.layerShell\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.layerShell\.var\.order



Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.overview



Animation curve to use while enetring/exiting the overview mode\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 300;
  enable = true;
}
```



## wayland\.windowManager\.scroll\.config\.animations\.overview\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.overview\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.overview\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.overview\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.overview\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.overview\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.overview\.var\.order



Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.style



The style to use for the animation\.
` "clip" ` clips the content, keeping the original content size,
while ` "scale" ` resizes the content while animating\.



*Type:*
one of “clip”, “scale”



*Default:*

```nix
"scale"
```



## wayland\.windowManager\.scroll\.config\.animations\.windowFullscreen



Animation curve to use while switching between fullscreen mode\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 500;
  enable = true;
  var = {
    controlPoints = [
      0.3
      0.5
      0.4
      1
    ];
    order = "simple";
  };
}
```



## wayland\.windowManager\.scroll\.config\.animations\.windowFullscreen\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.windowFullscreen\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowFullscreen\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowFullscreen\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowFullscreen\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowFullscreen\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowFullscreen\.var\.order



Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMove



Animation curve to use while moving windows\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 300;
  enable = true;
  off = {
    controlPoints = [
      0
      0.06
      0.04
      0
      1
      0
      0.4
      -0.6
      1
      -0.6
    ];
    order = 6;
    scale = 0.05;
  };
  var = {
    controlPoints = [
      0.215
      0.61
      0.355
      1
    ];
    order = 3;
  };
}
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMove\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMove\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMove\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMove\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMove\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMove\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMove\.var\.order



Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMoveFloat



Animation curve to use while a floating window is being moved by keyboard\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 300;
  enable = true;
}
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMoveFloat\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMoveFloat\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMoveFloat\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMoveFloat\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMoveFloat\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMoveFloat\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowMoveFloat\.var\.order



Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowOpen



Animation curve to use while a window is being opened\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 300;
  enable = true;
  var = {
    controlPoints = [
      0
      0
      1
      1
    ];
    order = 3;
  };
}
```



## wayland\.windowManager\.scroll\.config\.animations\.windowOpen\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.windowOpen\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowOpen\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowOpen\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowOpen\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowOpen\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowOpen\.var\.order



Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowSize



Animation curve to use while resizing windows\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 300;
  enable = true;
  var = {
    controlPoints = [
      -0.35
      0
      0
      0.5
    ];
    order = 3;
  };
}
```



## wayland\.windowManager\.scroll\.config\.animations\.windowSize\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.windowSize\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowSize\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowSize\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowSize\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowSize\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.windowSize\.var\.order



Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.workspaceSwitch



Animation curve to use while switching workspaces\.



*Type:*
submodule



*Default:*

```nix
{
  duration = 500;
  enable = true;
  var = {
    controlPoints = [
      0.215
      0.61
      0.355
      1
    ];
    order = "simple";
  };
}
```



## wayland\.windowManager\.scroll\.config\.animations\.workspaceSwitch\.enable



Whether to enable the animation\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.animations\.workspaceSwitch\.duration



Duration of the animation in milliseconds\.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.workspaceSwitch\.off\.controlPoints



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.workspaceSwitch\.off\.order



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.workspaceSwitch\.off\.scale



Defines the scale of the animation curve for the variable
that doesn’t change the operation/command\.
See ` scroll(5) ` for more details\.



*Type:*
null or signed integer or floating point number



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.workspaceSwitch\.var\.controlPoints



Defines the animation control points\. See ` scroll(5) ` for more details\.



*Type:*
null or (list of (signed integer or floating point number))



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.animations\.workspaceSwitch\.var\.order

Defines the order of the Bezier curve\. See ` scroll(5) ` for more details\.



*Type:*
null or unsigned integer, meaning >=0, or value “simple” (singular enum)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.assigns



An attribute set that assigns applications to workspaces based
on criteria\.



*Type:*
attribute set of list of attribute set of (string or boolean)



*Default:*

```nix
{ }
```



*Example:*

```nix
{
  "0: extra" = [
    {
      class = "^Firefox$";
      window_role = "About";
    }
  ];
  "1: web" = [
    {
      class = "^Firefox$";
    }
  ];
}
```



## wayland\.windowManager\.scroll\.config\.bars



Scroll bars settings blocks\. Set to empty list to remove bars completely\.



*Type:*
list of (submodule)



*Default:*

```nix
see code
```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors



Bar color settings\. All color classes can be specified using submodules
with ‘border’, ‘background’, ‘text’, fields and RGB color hex-codes as values\.
See default values for the reference\.
Note that ‘background’, ‘status’, and ‘separator’ parameters take a single RGB value\.

See [https://i3wm\.org/docs/userguide\.html\#_colors](https://i3wm\.org/docs/userguide\.html\#_colors)\.



*Type:*
submodule



*Default:*

```nix
{ }
```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors\.activeWorkspace



Border, background and text color for a workspace button when the workspace is active\.



*Type:*
null or (submodule)



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors\.background



Background color of the bar\.



*Type:*
null or string



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors\.bindingMode



Border, background and text color for the binding mode indicator



*Type:*
null or (submodule)



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors\.focusedBackground



Background color of the bar on the currently focused monitor output\.



*Type:*
null or string



*Default:*

```nix
null
```



*Example:*

```nix
"#000000"
```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors\.focusedSeparator



Text color to be used for the separator on the currently focused monitor output\.



*Type:*
null or string



*Default:*

```nix
null
```



*Example:*

```nix
"#666666"
```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors\.focusedStatusline



Text color to be used for the statusline on the currently focused monitor output\.



*Type:*
null or string



*Default:*

```nix
null
```



*Example:*

```nix
"#ffffff"
```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors\.focusedWorkspace



Border, background and text color for a workspace button when the workspace has focus\.



*Type:*
null or (submodule)



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors\.inactiveWorkspace



Border, background and text color for a workspace button when the workspace does not
have focus and is not active\.



*Type:*
null or (submodule)



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors\.separator



Text color to be used for the separator\.



*Type:*
null or string



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors\.statusline



Text color to be used for the statusline\.



*Type:*
null or string



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.colors\.urgentWorkspace



Border, background and text color for a workspace button when the workspace contains
a window with the urgency hint set\.



*Type:*
null or (submodule)



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.command



Command that will be used to start a bar\.



*Type:*
string



*Default:*

```nix
i3bar
```



*Example:*

```nix
"\${pkgs.waybar}/bin/waybar"
```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.extraConfig



Extra configuration lines for this bar\.



*Type:*
strings concatenated with “\\n”



*Default:*

```nix
""
```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.fonts



Font configuration for this bar\.



*Type:*
(list of string) or (submodule)



*Default:*

```nix
{ }
```



*Example:*

```nix
{
  names = [
    "DejaVu Sans Mono"
    "FontAwesome5Free"
  ];
  size = 11.0;
  style = "Bold Semi-Condensed";
}
```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.hiddenState



The default bar mode when ‘bar\.mode’ == ‘hide’\.



*Type:*
null or one of “hide”, “show”



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.id



Specifies the bar ID for the configured bar instance\.
If this option is missing, the ID is set to bar-x, where x corresponds
to the position of the embedding bar block in the config file\.



*Type:*
null or string



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.mode



Bar visibility mode\.



*Type:*
null or one of “dock”, “hide”, “invisible”



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.position



The edge of the screen scrollbar should show up\.



*Type:*
null or one of “top”, “bottom”



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.statusCommand



Command that will be used to get status lines\.



*Type:*
null or string



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.trayOutput



Where to output tray\.



*Type:*
null or string



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.trayPadding



Sets the pixel padding of the system tray\.
This padding will surround the tray on all sides and between each item\.



*Type:*
null or signed integer



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.workspaceButtons



Whether workspace buttons should be shown or not\.



*Type:*
null or boolean



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bars\.\*\.workspaceNumbers



Whether workspace numbers should be displayed within the workspace buttons\.



*Type:*
null or boolean



*Default:*

```nix
null for state version ≥ 20.09, as example otherwise

```



## wayland\.windowManager\.scroll\.config\.bindkeysToCode



Whether to make use of ` --to-code ` in keybindings\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.bindswitches



Binds \<switch> to execute the scroll command command on state changes\. Supported switches are lid (laptop
lid) and tablet (tablet mode) switches\. Valid values for state are on, off and toggle\. These switches are
on when the device lid is shut and when tablet mode is active respectively\. toggle is also supported to run
a command both when the switch is toggled on or off\.
See ` scroll(5) `\.



*Type:*
attribute set of (submodule)



*Default:*

```nix
"No bindswitches by default"
```



*Example:*

```nix
let
  laptop = "eDP-1";
in
{
  "lid:on" = {
    reload = true;
    locked = true;
    action = "output ${laptop} disable";
  };
  "lid:off" = {
    reload = true;
    locked = true;
    action = "output ${laptop} enable";
  };
}

```



## wayland\.windowManager\.scroll\.config\.bindswitches\.\<name>\.action



The scroll command to execute on state changes



*Type:*
string



## wayland\.windowManager\.scroll\.config\.bindswitches\.\<name>\.locked



Unless the flag --locked is set, the command
will not be run when a screen locking program
is active\. If there is a matching binding with
and without --locked, the one with will be preferred
when locked and the one without will be
preferred when unlocked\.



*Type:*
boolean



*Default:*

```nix
false
```



## wayland\.windowManager\.scroll\.config\.bindswitches\.\<name>\.reload



If the --reload flag is given, the binding will
also be executed when the config is reloaded\.
toggle bindings will not be executed on reload\.
The --locked flag will operate as normal so if
the config is reloaded while locked and
–locked is not given, the binding will not be
executed\.



*Type:*
boolean



*Default:*

```nix
false
```



## wayland\.windowManager\.scroll\.config\.colors



Color settings\. All color classes can be specified using submodules
with ‘border’, ‘background’, ‘text’, ‘indicator’ and ‘childBorder’ fields
and RGB color hex-codes as values\. See default values for the reference\.
Note that ‘scroll\.config\.colors\.background’ parameter takes a single RGB value\.

See [https://i3wm\.org/docs/userguide\.html\#_changing_colors](https://i3wm\.org/docs/userguide\.html\#_changing_colors)\.



*Type:*
submodule



*Default:*

```nix
{ }
```



## wayland\.windowManager\.scroll\.config\.colors\.background



Background color of the window\. Only applications which do not cover
the whole area expose the color\.



*Type:*
string



*Default:*

```nix
"#ffffff"
```



## wayland\.windowManager\.scroll\.config\.colors\.focused



A window which currently has the focus\.



*Type:*
submodule



*Default:*

```nix
{
  background = "#285577";
  border = "#4c7899";
  childBorder = "#285577";
  indicator = "#2e9ef4";
  text = "#ffffff";
}
```



## wayland\.windowManager\.scroll\.config\.colors\.focusedInactive



A window which is the focused one of its container,
but it does not have the focus at the moment\.



*Type:*
submodule



*Default:*

```nix
{
  background = "#5f676a";
  border = "#333333";
  childBorder = "#5f676a";
  indicator = "#484e50";
  text = "#ffffff";
}
```



## wayland\.windowManager\.scroll\.config\.colors\.pinned



A pinned column/row\.



*Type:*
submodule



*Default:*

```nix
{
  background = "#000000";
  border = "#beeeef";
  childBorder = "#beeeef";
  indicator = "#efeebe";
  text = "#ffffff";
}
```



## wayland\.windowManager\.scroll\.config\.colors\.pinnedFocused



A pinned column/row that is currently focused\.



*Type:*
submodule



*Default:*

```nix
{
  background = "#000000";
  border = "#6e8eef";
  childBorder = "#6e8eef";
  indicator = "#efeebe";
  text = "#ffffff";
}
```



## wayland\.windowManager\.scroll\.config\.colors\.placeholder



Background and text color are used to draw placeholder window
contents (when restoring layouts)\. Border and indicator are ignored\.



*Type:*
submodule



*Default:*

```nix
{
  background = "#0c0c0c";
  border = "#000000";
  childBorder = "#0c0c0c";
  indicator = "#000000";
  text = "#ffffff";
}
```



## wayland\.windowManager\.scroll\.config\.colors\.sticky



A sticky view/container\.



*Type:*
submodule



*Default:*

```nix
{
  background = "#000000";
  border = "#beeeef";
  childBorder = "#beeeef";
  indicator = "#efeebe";
  text = "#ffffff";
}
```



## wayland\.windowManager\.scroll\.config\.colors\.stickyFocused



A sticky view/container that is currently focused\.



*Type:*
submodule



*Default:*

```nix
{
  background = "#000000";
  border = "#6e8eef";
  childBorder = "#6e8eef";
  indicator = "#efeebe";
  text = "#ffffff";
}
```



## wayland\.windowManager\.scroll\.config\.colors\.unfocused



A window which is not focused\.



*Type:*
submodule



*Default:*

```nix
{
  background = "#222222";
  border = "#333333";
  childBorder = "#222222";
  indicator = "#292d2e";
  text = "#888888";
}
```



## wayland\.windowManager\.scroll\.config\.colors\.urgent



A window which has its urgency hint activated\.



*Type:*
submodule



*Default:*

```nix
{
  background = "#900000";
  border = "#2f343a";
  childBorder = "#900000";
  indicator = "#900000";
  text = "#ffffff";
}
```



## wayland\.windowManager\.scroll\.config\.defaultWorkspace



The default workspace to show when sway is launched\.
This must to correspond to the value of the keybinding of the default workspace\.



*Type:*
null or string



*Default:*

```nix
null
```



*Example:*

```nix
"workspace number 9"
```



## wayland\.windowManager\.scroll\.config\.down



Home row direction key for moving down\.



*Type:*
string



*Default:*

```nix
"down"
```



## wayland\.windowManager\.scroll\.config\.floating



Floating window settings\.



*Type:*
submodule



*Default:*

```nix
{ }
```



## wayland\.windowManager\.scroll\.config\.floating\.border



Floating windows border width\.



*Type:*
signed integer



*Default:*

```nix
2
```



## wayland\.windowManager\.scroll\.config\.floating\.criteria



List of criteria for windows that should be opened in a floating mode\.



*Type:*
list of attribute set of (string or boolean)



*Default:*

```nix
[ ]
```



*Example:*

```nix
[
  {
    title = "Steam - Update News";
  }
  {
    class = "Pavucontrol";
  }
]
```



## wayland\.windowManager\.scroll\.config\.floating\.modifier



Modifier key or keys that can be used to drag floating windows\.



*Type:*
string



*Default:*

```nix
"scroll.config.modifier"
```



*Example:*

```nix
"Mod4"
```



## wayland\.windowManager\.scroll\.config\.floating\.titlebar



Whether to show floating window titlebars\.



*Type:*
boolean



*Default:*

```nix
''
  true for state version ≥ 23.05
  false for state version < 23.05
''
```



## wayland\.windowManager\.scroll\.config\.focus



Focus related settings\.



*Type:*
submodule



*Default:*

```nix
{ }
```



## wayland\.windowManager\.scroll\.config\.focus\.followMouse



Whether focus should follow the mouse\.



*Type:*
one of “yes”, “no”, “always” or boolean



*Default:*

```nix
"yes"
```



## wayland\.windowManager\.scroll\.config\.focus\.forceWrapping



Whether to force focus wrapping in tabbed or stacked containers\.

This option is deprecated, use ` focus.wrapping ` instead\.



*Type:*
boolean



*Default:*

```nix
false
```



## wayland\.windowManager\.scroll\.config\.focus\.mouseWarping



Whether mouse cursor should be warped to the center of the window when switching focus
to a window on a different output\.



*Type:*
boolean or one of “container”, “output”



*Default:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.focus\.newWindow



This option modifies focus behavior on new window activation\.

See [https://i3wm\.org/docs/userguide\.html\#focus_on_window_activation](https://i3wm\.org/docs/userguide\.html\#focus_on_window_activation)



*Type:*
one of “smart”, “urgent”, “focus”, “none”



*Default:*

```nix
"smart"
```



*Example:*

```nix
"none"
```



## wayland\.windowManager\.scroll\.config\.focus\.wrapping



Whether the window focus commands automatically wrap around the edge of containers\.

See [https://i3wm\.org/docs/userguide\.html\#_focus_wrapping](https://i3wm\.org/docs/userguide\.html\#_focus_wrapping)



*Type:*
one of “yes”, “no”, “force”, “workspace”



*Default:*

```nix
if focus.forceWrapping then "yes" else "no"
```



## wayland\.windowManager\.scroll\.config\.fonts



Font configuration for window titles, nagbar…



*Type:*
(list of string) or (submodule)



*Default:*

```nix
{ }
```



*Example:*

```nix
{
  names = [
    "DejaVu Sans Mono"
    "FontAwesome5Free"
  ];
  size = 11.0;
  style = "Bold Semi-Condensed";
}
```



## wayland\.windowManager\.scroll\.config\.gaps



Gaps related settings\.



*Type:*
null or (submodule)



*Default:*

```nix
null
```



## wayland\.windowManager\.scroll\.config\.gaps\.bottom



Bottom gaps value\.



*Type:*
null or signed integer



*Default:*

```nix
null
```



*Example:*

```nix
5
```



## wayland\.windowManager\.scroll\.config\.gaps\.horizontal



Horizontal gaps value\.



*Type:*
null or signed integer



*Default:*

```nix
null
```



*Example:*

```nix
5
```



## wayland\.windowManager\.scroll\.config\.gaps\.inner



Inner gaps value\.



*Type:*
null or signed integer



*Default:*

```nix
null
```



*Example:*

```nix
12
```



## wayland\.windowManager\.scroll\.config\.gaps\.left



Left gaps value\.



*Type:*
null or signed integer



*Default:*

```nix
null
```



*Example:*

```nix
5
```



## wayland\.windowManager\.scroll\.config\.gaps\.outer



Outer gaps value\.



*Type:*
null or signed integer



*Default:*

```nix
null
```



*Example:*

```nix
5
```



## wayland\.windowManager\.scroll\.config\.gaps\.right



Right gaps value\.



*Type:*
null or signed integer



*Default:*

```nix
null
```



*Example:*

```nix
5
```



## wayland\.windowManager\.scroll\.config\.gaps\.smartBorders



This option controls whether to disable container borders on
workspace with a single container\.



*Type:*
one of “on”, “off”, “no_gaps”



*Default:*

```nix
"off"
```



## wayland\.windowManager\.scroll\.config\.gaps\.smartGaps



This option controls whether to disable all gaps (outer and inner)
on workspace with a single container\.



*Type:*
boolean or one of “on”, “off”, “inverse_outer”



*Default:*

```nix
"off"
```



*Example:*

```nix
"on"
```



## wayland\.windowManager\.scroll\.config\.gaps\.top



Top gaps value\.



*Type:*
null or signed integer



*Default:*

```nix
null
```



*Example:*

```nix
5
```



## wayland\.windowManager\.scroll\.config\.gaps\.vertical



Vertical gaps value\.



*Type:*
null or signed integer



*Default:*

```nix
null
```



*Example:*

```nix
5
```



## wayland\.windowManager\.scroll\.config\.input



An attribute set that defines input modules\. See
` scroll-input(5) `
for options\.



*Type:*
attribute set of attribute set of anything



*Default:*

```nix
{ }
```



*Example:*

```nix
{
  "*" = {
    xkb_variant = "dvorak";
  };
}
```



## wayland\.windowManager\.scroll\.config\.jump



Configure jump mode options\.



*Type:*
submodule



## wayland\.windowManager\.scroll\.config\.jump\.keys



Keys to use for jump mode\. They will also be used as window labels\.



*Type:*
string



*Default:*

```nix
"1234"
```



## wayland\.windowManager\.scroll\.config\.jump\.keysAlt



Alternative keys that correspond to the regular keys but are not
used as labels\.
Example for an AZERTY keyboard:

```
keys = "1234";
keysAlt = [ "ampersand" "eacute" "quotedbl" "apostrophe" ];
```

This makes pressing ampersand have the same effect as pressing 1,
eacute same as 2 and so on\.
Windows are still labeled with 1, 2, 3 and 4 and keys 1234 still
work the same\.



*Type:*
list of string



*Default:*

```nix
[ ]
```



*Example:*

```nix
[
  "ampersand"
  "eacute"
  "quotedbl"
  "apostrophe"
]
```



## wayland\.windowManager\.scroll\.config\.jump\.labels\.background



Background color of the jump labels\.



*Type:*
string



*Default:*

```nix
"#00000000"
```



## wayland\.windowManager\.scroll\.config\.jump\.labels\.color



Color of the jump labels\.



*Type:*
string



*Default:*

```nix
"#159E3080"
```



## wayland\.windowManager\.scroll\.config\.jump\.labels\.scale



Scale of the labels within the windows\.



*Type:*
signed integer or floating point number



*Default:*

```nix
0.5
```



## wayland\.windowManager\.scroll\.config\.jump\.labels\.swallow



Makes pressing a key in jump mode update the labels, showing only
showing only the characters still available to press\.



*Type:*
boolean



*Default:*

```nix
false
```



## wayland\.windowManager\.scroll\.config\.keybindings



An attribute set that assigns a key press to an action using a key symbol\.
See [https://i3wm\.org/docs/userguide\.html\#keybindings](https://i3wm\.org/docs/userguide\.html\#keybindings)\.

Consider to use ` lib.mkOptionDefault ` function to extend or override
default keybindings instead of specifying all of them from scratch\.



*Type:*
attribute set of (null or string)



*Default:*

```nix
"Default scroll keybindings."
```



*Example:*

```nix
let
  modifier = config.wayland.windowManager.scroll.config.modifier;
in lib.mkOptionDefault {
  "${modifier}+Return" = "exec ${cfg.config.terminal}";
  "${modifier}+Shift+q" = "kill";
  "${modifier}+d" = "exec ${cfg.config.menu}";
}

```



## wayland\.windowManager\.scroll\.config\.keycodebindings



An attribute set that assigns keypress to an action using key code\.
See [https://i3wm\.org/docs/userguide\.html\#keybindings](https://i3wm\.org/docs/userguide\.html\#keybindings)\.



*Type:*
attribute set of (null or string)



*Default:*

```nix
{ }
```



*Example:*

```nix
{
  "214" = "exec /bin/script.sh";
}
```



## wayland\.windowManager\.scroll\.config\.left



Home row direction key for moving left\.



*Type:*
string



*Default:*

```nix
"left"
```



## wayland\.windowManager\.scroll\.config\.menu



Default launcher to use\.



*Type:*
string



*Default:*

```nix
${pkgs.dmenu}/bin/dmenu_path | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils}/bin/xargs scrollmsg exec --
```



*Example:*

```nix
"bemenu-run"
```



## wayland\.windowManager\.scroll\.config\.modes



An attribute set that defines binding modes and keybindings
inside them

Only basic keybinding is supported (bindsym keycomb action),
for more advanced setup use ‘scroll\.extraConfig’\.



*Type:*
attribute set of attribute set of string



*Default:*

```nix
{
  resize = {
    # Binds arrow keys to resizing commands
    ${cfg.config.left}" = "resize shrink width 10 px";
    ${cfg.config.down}" = "resize grow height 10 px";
    ${cfg.config.up}" = "resize shrink height 10 px";
    ${cfg.config.right}" = "resize grow width 10 px";

    "Left" = "resize shrink width 10 px";
    "Down" = "resize grow height 10 px";
    "Up" = "resize shrink height 10 px";
    "Right" = "resize grow width 10 px";

    # Exit resize mode
    "Escape" = "mode default";
    "Return" = "mode default";
  };
}

```



## wayland\.windowManager\.scroll\.config\.modifier



Modifier key that is used for all default keybindings\.



*Type:*
one of “Shift”, “Control”, “Mod1”, “Mod2”, “Mod3”, “Mod4”, “Mod5” or string



*Default:*

```nix
"Mod1"
```



*Example:*

```nix
"Mod4"
```



## wayland\.windowManager\.scroll\.config\.output



An attribute set that defines output modules\. See
` scroll-output(5) `
for options\.



*Type:*
attribute set of attribute set of anything



*Default:*

```nix
{ }
```



*Example:*

```nix
{
  HDMI-A-2 = {
    bg = "~/path/to/background.png fill";
  };
}
```



## wayland\.windowManager\.scroll\.config\.right



Home row direction key for moving right\.



*Type:*
string



*Default:*

```nix
"right"
```



## wayland\.windowManager\.scroll\.config\.seat



An attribute set that defines seat modules\. See
` scroll-input(5) `
for options\.



*Type:*
attribute set of attribute set of anything



*Default:*

```nix
{ }
```



*Example:*

```nix
{
  "*" = {
    hide_cursor = "when-typing enable";
  };
}
```



## wayland\.windowManager\.scroll\.config\.snap



Configure window snapping options\.



*Type:*
submodule



## wayland\.windowManager\.scroll\.config\.snap\.borderOverlap



Whether window borders should overlap when snapping\.



*Type:*
boolean



*Default:*

```nix
false
```



## wayland\.windowManager\.scroll\.config\.snap\.gap\.window



Maximum distance between window borders to snap them\.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
0
```



## wayland\.windowManager\.scroll\.config\.snap\.gap\.workspace



Maximum distance between workspace and window borders to snap them



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
0
```



## wayland\.windowManager\.scroll\.config\.snap\.respectGaps\.inner



Whether snapping should respect ` gaps inner `



*Type:*
boolean



*Default:*

```nix
false
```



## wayland\.windowManager\.scroll\.config\.snap\.respectGaps\.outer



Whether snapping should respect ` gaps outer `



*Type:*
boolean



*Default:*

```nix
false
```



## wayland\.windowManager\.scroll\.config\.startup



Commands that should be executed at startup\.

See [https://i3wm\.org/docs/userguide\.html\#_automatically_starting_applications_on_i3_startup](https://i3wm\.org/docs/userguide\.html\#_automatically_starting_applications_on_i3_startup)\.



*Type:*
list of (submodule)



*Default:*

```nix
[ ]
```



*Example:*

```nix
[
{ command = "systemctl --user restart waybar"; always = true; }
{ command = "dropbox start"; }
{ command = "firefox"; }
]

```



## wayland\.windowManager\.scroll\.config\.startup\.\*\.always



Whether to run command on each scroll restart\.



*Type:*
boolean



*Default:*

```nix
false
```



## wayland\.windowManager\.scroll\.config\.startup\.\*\.command



Command that will be executed on startup\.



*Type:*
string



## wayland\.windowManager\.scroll\.config\.terminal



Default terminal to run\.



*Type:*
string



*Default:*

```nix
${pkgs.kitty}/bin/kitty
```



*Example:*

```nix
"alacritty"
```



## wayland\.windowManager\.scroll\.config\.up



Home row direction key for moving up\.



*Type:*
string



*Default:*

```nix
"up"
```



## wayland\.windowManager\.scroll\.config\.window



Window titlebar and border settings\.



*Type:*
submodule



*Default:*

```nix
{ }
```



## wayland\.windowManager\.scroll\.config\.window\.border



Window border width\.



*Type:*
signed integer



*Default:*

```nix
2
```



## wayland\.windowManager\.scroll\.config\.window\.borderRadius



Default window border radius\.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
0
```



## wayland\.windowManager\.scroll\.config\.window\.commands



List of commands that should be executed on specific windows\.
See ` for_window ` scrollwm option documentation\.



*Type:*
list of (submodule)



*Default:*

```nix
[ ]
```



*Example:*

```nix
[
  {
    command = "border pixel 1";
    criteria = {
      class = "XTerm";
    };
  }
]
```



## wayland\.windowManager\.scroll\.config\.window\.commands\.\*\.command

Scrollwm command to execute\.



*Type:*
string



*Example:*

```nix
"border pixel 1"
```



## wayland\.windowManager\.scroll\.config\.window\.commands\.\*\.criteria



Criteria of the windows on which command should be executed\.

A value of ` true ` is equivalent to using an empty
criteria (which is different from an empty string criteria)\.



*Type:*
attribute set of (string or boolean)



*Default:*

```nix
{ }
```



*Example:*

```nix
{
  title = "x200: ~/work";
  floating = true;
};

```



## wayland\.windowManager\.scroll\.config\.window\.dim\.enable



Enable dimming of unfocused windows\.



*Type:*
boolean



*Default:*

```nix
false
```



## wayland\.windowManager\.scroll\.config\.window\.dim\.color



Color to use when dimming inactive windows\.



*Type:*
string



*Default:*

```nix
"#00000040"
```



## wayland\.windowManager\.scroll\.config\.window\.hideEdgeBorders



Hide window borders adjacent to the screen edges\.



*Type:*
one of “none”, “vertical”, “horizontal”, “both”, “smart”, “smart_no_gaps”, “–i3 none”, “–i3 vertical”, “–i3 horizontal”, “–i3 both”, “–i3 smart”, “–i3 smart_no_gaps”



*Default:*

```nix
"none"
```



## wayland\.windowManager\.scroll\.config\.window\.shadow\.enable



Enable window shadows



*Type:*
boolean



*Default:*

```nix
false
```



## wayland\.windowManager\.scroll\.config\.window\.shadow\.blur



Value of the shadow blur in pixels,
where 0 means sharp\.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
30
```



## wayland\.windowManager\.scroll\.config\.window\.shadow\.color



Color of the shadow\.



*Type:*
string



*Default:*

```nix
"#00000040"
```



## wayland\.windowManager\.scroll\.config\.window\.shadow\.dynamic



Enable dynamic shadows\.
Dynamic shadows change the position of a shadow based on the
location of the window\.



*Type:*
boolean



*Default:*

```nix
false
```



## wayland\.windowManager\.scroll\.config\.window\.shadow\.offset



Offset from the shadow from the window\.



*Type:*
list of signed integer



*Default:*

```nix
[
  40
  40
]
```



## wayland\.windowManager\.scroll\.config\.window\.shadow\.size



Set shadow size in pixels\.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
40
```



## wayland\.windowManager\.scroll\.config\.window\.titlebar



Whether to show window titlebars\.



*Type:*
boolean



*Default:*

```nix
''
  true for state version ≥ 23.05
  false for state version < 23.05
''
```



## wayland\.windowManager\.scroll\.config\.window\.titlebarBorderRadius



Border radius of the window titlebar in pixels\.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
0
```



## wayland\.windowManager\.scroll\.config\.workspaceAutoBackAndForth



Assume you are on workspace “1: www” and switch to “2: IM” using
mod+2 because somebody sent you a message\. You don’t need to remember
where you came from now, you can just press $mod+2 again to switch
back to “1: www”\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.config\.workspaceLayout



The mode in which new containers on workspace level will
start\.



*Type:*
one of “default”, “stacking”, “tabbed”



*Default:*

```nix
"default"
```



*Example:*

```nix
"tabbed"
```



## wayland\.windowManager\.scroll\.config\.workspaceOutputAssign



Assign workspaces to outputs\.



*Type:*
list of (submodule)



*Default:*

```nix
[ ]
```



## wayland\.windowManager\.scroll\.config\.workspaceOutputAssign\.\*\.output



Name(s) of the output(s) from `    scrollmsg -t get_outputs  `\.



*Type:*
string or list of string



*Default:*

```nix
""
```



*Example:*

```nix
"eDP"
```



## wayland\.windowManager\.scroll\.config\.workspaceOutputAssign\.\*\.workspace



Name of the workspace to assign\.



*Type:*
signed integer or string



*Default:*

```nix
""
```



*Example:*

```nix
"Web"
```



## wayland\.windowManager\.scroll\.extraConfig



Extra configuration lines to add to ~/\.config/scroll/config\.



*Type:*
strings concatenated with “\\n”



*Default:*

```nix
""
```



## wayland\.windowManager\.scroll\.extraConfigEarly



Like extraConfig, except lines are added to ~/\.config/scroll/config before all other configuration\.



*Type:*
strings concatenated with “\\n”



*Default:*

```nix
""
```



## wayland\.windowManager\.scroll\.extraOptions



Command line arguments passed to launch scroll\. Please DO NOT report
issues if you use an unsupported GPU (proprietary drivers)\.



*Type:*
list of string



*Default:*

```nix
[ ]
```



*Example:*

```nix
[
  "--verbose"
  "--debug"
]
```



## wayland\.windowManager\.scroll\.extraSessionCommands



Shell commands executed just before scroll is started\.



*Type:*
strings concatenated with “\\n”



*Default:*

```nix
""
```



*Example:*

```nix
''
  export SDL_VIDEODRIVER=wayland
  # needs qt5.qtwayland in systemPackages
  export QT_QPA_PLATFORM=wayland
  export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
  # Fix for some Java AWT applications (e.g. Android Studio),
  # use this if they aren't displayed properly:
  export _JAVA_AWT_WM_NONREPARENTING=1
''
```



## wayland\.windowManager\.scroll\.scrollnag\.enable



Whether to enable configuration of scrollnag, a lightweight error bar for scroll\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.scrollnag\.settings



Configuration written to
` $XDG_CONFIG_HOME/scrollnag/config `\.

See
` scrollnag(5) `
for a list of available options and an example configuration\.
Note, configurations declared under ` <config> `
will override the default type values of scrollnag\.



*Type:*
attribute set of attribute set of (Scrollnag config atom (null, bool, int, float, str))



*Default:*

```nix
{ }
```



*Example:*

```nix
{
  "<config>" = {
    edge = "bottom";
    font = "Dina 12";
  };

  green = {
    edge = "top";
    background = "00AA00";
    text = "FFFFFF";
    button-background = "00CC00";
    message-padding = 10;
  };
}

```



## wayland\.windowManager\.scroll\.systemd\.enable



Whether to enable ` scroll-session.target ` on
scroll startup\. This links to
` graphical-session.target `\.
Some important environment variables will be imported to systemd
and dbus user environment before reaching the target, including

 - ` DISPLAY `
 - ` WAYLAND_DISPLAY `
 - ` I3SOCK `
 - ` SWAYSOCK `
 - ` SCROLLSOCK `
 - ` XDG_CURRENT_DESKTOP `
 - ` XDG_SESSION_TYPE `
 - ` NIXOS_OZONE_WL `
 - ` XCURSOR_THEME `
 - ` XCURSOR_SIZE `
   You can extend this list using the ` systemd.variables ` option\.



*Type:*
boolean



*Default:*

```nix
true
```



*Example:*

```nix
false
```



## wayland\.windowManager\.scroll\.systemd\.dbusImplementation



The D-Bus implementation used on the system\.
This affects which tool is used to import environment variables when starting the scroll session\.
On NixOS, this should match the value of the option [` services.dbus.implementation ` (NixOS)](https://nixos\.org/manual/nixos/stable/options\#opt-services\.dbus\.implementation)\.
When set to ` dbus `, ` dbus-update-activation-environment --systemd <variables> ` is run\.
Otherwise, when set to ` broker `, ` systemctl --user import-environment <variables> ` is run\.
See [https://github\.com/swaywm/sway/wiki\#systemd-and-dbus-activation-environments](https://github\.com/swaywm/sway/wiki\#systemd-and-dbus-activation-environments) for more documentation\.



*Type:*
one of “dbus”, “broker”



*Default:*

```nix
"dbus"
```



*Example:*

```nix
"broker"
```



## wayland\.windowManager\.scroll\.systemd\.extraCommands



Extra commands to run after D-Bus activation\.



*Type:*
list of string



*Default:*

```nix
[
  "systemctl --user reset-failed"
  "systemctl --user start scroll-session.target"
  "scroll -mt subscribe '[]' || true"
  "systemctl --user stop scroll-session.target"
]
```



## wayland\.windowManager\.scroll\.systemd\.variables



Environment variables imported into the systemd and D-Bus user environment\.



*Type:*
list of string



*Default:*

```nix
[
  "DISPLAY"
  "WAYLAND_DISPLAY"
  "I3SOCK"
  "SWAYSOCK"
  "SCROLLSOCK"
  "XDG_CURRENT_DESKTOP"
  "XDG_SESSION_TYPE"
  "NIXOS_OZONE_WL"
  "XCURSOR_THEME"
  "XCURSOR_SIZE"
]
```



*Example:*

```nix
[
  "--all"
]
```



## wayland\.windowManager\.scroll\.systemd\.xdgAutostart



Whether to enable autostart of applications using
[` systemd-xdg-autostart-generator(8) `](https://www.freedesktop.org/software/systemd/man/systemd-xdg-autostart-generator.html)
\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.wrapperFeatures



Attribute set of features to enable in the wrapper\.



*Type:*
submodule



*Default:*

```nix
{ }
```



*Example:*

```nix
{
  gtk = true;
}
```



## wayland\.windowManager\.scroll\.wrapperFeatures\.base



Whether to make use of the base wrapper to execute extra session commands and prepend a
dbus-run-session to the scroll command\.



*Type:*
boolean



*Default:*

```nix
true
```



*Example:*

```nix
false
```



## wayland\.windowManager\.scroll\.wrapperFeatures\.gtk



Whether to make use of the wrapGAppsHook wrapper to execute scroll with required environment
variables for GTK applications\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## wayland\.windowManager\.scroll\.xwayland



Enable xwayland, which is needed for the default configuration of scroll\.



*Type:*
boolean



*Default:*

```nix
true
```


