import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxTextFormat;
import funkin.game.ComboRating;

var TimeCounter:FlxSprite;
var GiftIcon:FlxSprite;
var StatusLabel:FlxText;
var fcColor:FlxColor = FlxColor.YELLOW;
var timeAm = 0;
var fcStatus = 'SFC';
var goodorbadfc = 'good';
var bullshitTween:FlxTween;
var bullshitTween2:FlxTween;

function postCreate()
{
    TimeCounter = new FlxSprite(1096.85, 62).loadGraphic(Paths.image('timeCounter'));
    TimeCounter.frames = Paths.getFrames('timeCounter');
    TimeCounter.animation.addByPrefix('0', '00000', 24);
    TimeCounter.animation.addByPrefix('1', '10000', 24);
    TimeCounter.animation.addByPrefix('2', '20000', 24);
    TimeCounter.animation.addByPrefix('3', '30000', 24);
    TimeCounter.animation.addByPrefix('4', '40000', 24);
    TimeCounter.animation.addByPrefix('5', '50000', 24);
    TimeCounter.animation.addByPrefix('6', '60000', 24);
    TimeCounter.animation.addByPrefix('7', '70000', 24);
    TimeCounter.animation.addByPrefix('8', '80000', 24);
    TimeCounter.animation.addByPrefix('9', '90000', 24);
    TimeCounter.animation.play('0');
    TimeCounter.scale.set(1.3, 1.3);
    TimeCounter.cameras = [camHUD];
    add(TimeCounter);

    var AmSign:FlxSprite = new FlxSprite(1132.35, 57).loadGraphic(Paths.image('amSign'));
    AmSign.cameras = [camHUD];
    add(AmSign);

    var NightCounter:FlxSprite = new FlxSprite(1087, 98).loadGraphic(Paths.image('nightCounter'));
    NightCounter.scale.set(1.3, 1.3);
    NightCounter.cameras = [camHUD];
    add(NightCounter);

    var camOutline:FlxSprite = new FlxSprite(47, 34).loadGraphic(Paths.image('camOutline'));
    camOutline.scale.set(0.915625, 0.894444);
    camOutline.cameras = [camHUD];
    camOutline.updateHitbox(false);
    add(camOutline);

    GiftIcon = new FlxSprite(999, -2).loadGraphic(Paths.image('giftIcon'));
    GiftIcon.scale.set(0.3, 0.3);
    GiftIcon.cameras = [camHUD];
    add(GiftIcon);

    StatusLabel = new FunkinText(127, 532, 0, "#Score: 0\nRank: 0% (?) - #?#\nMisses: 0#", 0, true);
    StatusLabel.setFormat("fonts/Pixellari.ttf", 30, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    StatusLabel.borderSize = 4;
    StatusLabel.cameras = [camHUD];
    add(StatusLabel);

    StatusLabel.applyMarkup("#" + StatusLabel.text + "#", [new FlxTextFormatMarkerPair(new FlxTextFormat(fcColor), "#")]);
    
    healthBar.scale.x *= 0.9;
    healthBar.scale.y *= 0.9;
    healthBar.y -= 32;
    
    healthBarBG.scale.x *= 0.9;
    healthBarBG.scale.y *= 0.9;
    healthBarBG.y -= 32;
    
    iconP1.y -= 32;
    iconP2.y -= 32;

    comboRatings = [new ComboRating(0, "Awful", 0xFFFFFFFF), new ComboRating(0.2, "Terrible", 0xFFFFFFFF), new ComboRating(0.4, "Shit", 0xFFFFFFFF), new ComboRating(0.5, "Bad", 0xFFFFFFFF), new ComboRating(0.6, "Bruh", 0xFFFFFFFF), new ComboRating(0.69, "Meh", 0xFFFFFFFF), new ComboRating(0.7, "Good", 0xFFFFFFFF), new ComboRating(0.8, "Great", 0xFFFFFFFF), new ComboRating(0.9, "BENEDICT!", 0xFFFFFFFF), new ComboRating(0.95, "BURNING!!", 0xFFFFFFFF), new ComboRating(1, "EXOTIC!!!", 0xFFFFFFFF)];
}

function songStart()
{
    var oneam:FlxTimer = new FlxTimer().start(55.83333333333333 * 1, function() {timeAm += 1;});
    var twoam:FlxTimer = new FlxTimer().start(55.83333333333333 * 2, function() {timeAm += 1;});
    var threeam:FlxTimer = new FlxTimer().start(55.83333333333333 * 3, function() {timeAm += 1;});
    var fouram:FlxTimer = new FlxTimer().start(55.83333333333333 * 4, function() {timeAm += 1;});
    var fiveam:FlxTimer = new FlxTimer().start(55.83333333333333 * 5, function() {timeAm += 1;});
    var sixam:FlxTimer = new FlxTimer().start(55.83333333333333 * 6, function() {timeAm += 1;});
}

function postUpdate() 
{
    // trace(timeAm);
    TimeCounter.animation.play(timeAm);
    
    fcColor = FlxColor.RED;
    if(misses < 10)
        fcColor = FlxColor.YELLOW;

    //FC Status
    if(misses == 0)
        fcStatus = 'FC';
    if(goodorbadfc == 'good')
        fcStatus = 'GFC';
    if(misses > 0 && misses < 10)
        fcStatus = 'SDCB';
    if(misses > 10)
        fcStatus = 'Clear';
    if(accuracy == 1)
        fcStatus = 'SFC';
    if(accuracy <= 0)
        fcStatus = '?';
    
    StatusLabel.text = "#Score: " + songScore + "\nRank: 0% (?) - #?#\nMisses: " + misses + "#";
    if(accuracy >= 0)
        StatusLabel.text = "#Score: " + songScore + "\nRank: " + CoolUtil.quantize(accuracy * 100, 100) + "% (" + curRating.rating + ") - #" + fcStatus + "#\nMisses: " + misses + "#";
    StatusLabel.applyMarkup("#" + StatusLabel.text + "#", [new FlxTextFormatMarkerPair(new FlxTextFormat(fcColor), "#")]);

    var newOffset = 23;
    var newCenter:Float = (healthBar.x + healthBar.width * FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0)) * 0.9 + 64;

    iconP1.x = newCenter - newOffset;
    iconP2.x = newCenter - (iconP2.width - newOffset);

    iconP1.scale.set(lerp(iconP1.scale.x, 0.9, 0.33), lerp(iconP1.scale.y, 0.9, 0.33));
	iconP2.scale.set(lerp(iconP2.scale.x, 0.9, 0.33), lerp(iconP2.scale.y, 0.9, 0.33));

	iconP1.updateHitbox();
	iconP2.updateHitbox();
}

function onPlayerHit(e) {
    if (!e.note.isSustainNote)
    {
        bullshitTween?.cancel();
        bullshitTween2?.cancel();
        StatusLabel.scale.set(1.05, 1.05);
        StatusLabel.x = 137;
        StatusLabel.y = 537;
        bullshitTween = FlxTween.tween(StatusLabel, {'scale.x': 1, 'scale.y': 1}, 0.33, {ease: FlxEase.cubeInOut});
        bullshitTween2 = FlxTween.tween(StatusLabel, {'x': 127, 'y': 532}, 0.33, {ease: FlxEase.cubeInOut});
        
        if(e.rating == 'good' && goodorbadfc != 'bad')
            goodorbadfc = 'good';
        if(e.rating == 'bad')
            goodorbadfc = 'bad';
        if(e.rating == 'shit')
            goodorbadfc = 'bad';
    }
}

function beatHit() 
{
    iconP1.scale.set(1.08, 1.08);
    iconP2.scale.set(1.08, 1.08);

    if(curBeat % 2 == 1 && strumLines.members[1].characters[0].getAnimName() == 'idle')
        boyfriend.playAnim('idle');
}