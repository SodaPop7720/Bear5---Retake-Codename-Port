import funkin.game.ComboRating;

var epicTween:FlxTween;

function postCreate()
{
    camGame.followLerp *= 2;
    
    comboGroup.x = 355;
    comboGroup.y = 225;
}

function postUpdate()
{
    comboGroup.scale.x = 0.3;
    comboGroup.scale.y = 0.3;
}

function onNoteCreation(e) 
	e.note.splash = "psych";

function beatHit() 
{
    epicTween?.cancel();
    red.alpha = 1;
    epicTween = FlxTween.tween(red, {'alpha': 0.5}, 0.8, {ease: FlxEase.cubeOut});
}