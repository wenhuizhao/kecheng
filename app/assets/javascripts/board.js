window.onload = function() {

    var canvas = new fabric.Canvas('canvas');
    
    jQuery(document).ready( function() {
        $("#text_input").click(function(){
            canvas.isDrawingMode = false;
    
            if (canvas.getContext) {
                var context = canvas.getContext('2d');
            }
    
            var text, size, color;
            var mouse_pos = { x:0 , y:0 };
    
            text = $('#text').val();
            size = 16 
            color = '#000'
    
            canvas.observe('mouse:down', function(e) {
                mouse_pos = canvas.getPointer(e.e);
                size = parseInt(size, 10);
                canvas.add(new fabric.Text(text, {
                    fontFamily: 'Arial',
                    fontSize: size,
                    left: mouse_pos.x,
                    top: mouse_pos.y,
                    textAlign: "left",
                    fontWeight: 'bold'
                }));
                canvas.off('mouse:down');
                canvas.renderAll();
                canvas.calcOffset();
             });
        });
      $("#draw").click(function(){
          canvas.isDrawingMode = true;
          canvas.freeDrawingLineWidth = 5;
          canvas.renderAll();
          canvas.calcOffset();
      });
      $("#save").click(function(){
          canvas.isDrawingMode = false;
      if(!window.localStorage){alert("This function is not supported by your browser."); return;}
          // save to localStorage
          var json = JSON.stringify(canvas);
          window.localStorage.setItem("hoge", json);
      });
      $("#load").click(function(){
          canvas.isDrawingMode = false;
          if(!window.localStorage){alert("This function is not supported by your browser."); return;}
          //clear canvas
          canvas.clear();
          //load from localStorage
          canvas.loadFromJSON(window.localStorage.getItem("hoge"));
          // re-render the canvas
          canvas.renderAll();
          // optional
          canvas.calcOffset();
      });
    
      $("#clear").click(function(){
          canvas.isDrawingMode = false;
          canvas.clear();
      });
      
      
      $("#remove").click(function(){
          canvas.isDrawingMode = false;
          var activeObject = canvas.getActiveObject(),
          activeGroup = canvas.getActiveGroup();
          if (activeObject) {
             canvas.remove(activeObject);
          }
          else if (activeGroup) {
             var objectsInGroup = activeGroup.getObjects();
             canvas.discardActiveGroup();
             objectsInGroup.forEach(function(object) {
             canvas.remove(object);
             });
          }
      
      });
      
    });
    
    canvas.calcOffset();
    
    document.onkeyup = function(e) {
      canvas.renderAll();
    };
    
    setTimeout(function() {
      canvas.calcOffset();
    }, 100);

};
