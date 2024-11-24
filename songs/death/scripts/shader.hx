public var scanline:CustomShader;

function postCreate()
{
    scanline = new CustomShader("Scanline");
    scanline.scanLineCount = 120;
    camHUD.addShader(scanline);
    FlxG.camera.addShader(scanline);
}