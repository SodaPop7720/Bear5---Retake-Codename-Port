var cammove = 4;
public var canFunniPoseThing:Bool = true;

function postUpdate() {
    if (canFunniPoseThing) {
        switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
            case 'singLEFT', 'singLEFT-alt': 
                camFollow.x -= cammove;
            case 'singDOWN', 'singDOWN-alt': 
                camFollow.y += cammove;
            case 'singUP', 'singUP-alt': 
                camFollow.y -= cammove;
            case 'singRIGHT', 'singRIGHT-alt': 
                camFollow.x += cammove;
            case 'idle', 'idle-alt', 'hey':
        }
    }
}