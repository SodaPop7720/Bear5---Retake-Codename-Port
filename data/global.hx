import openfl.Lib;
import funkin.backend.utils.WindowUtils;
import lime.graphics.Image;

function preStateSwitch() {
    WindowUtils.resetTitle();
        Main.framerateSprite.codenameBuildField.text = "";
        window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('gameIcon'))));
        window.title = "Funkin-Bear5Remake";
}