current_thumb = null;

function createlightbox()
{
    var lb = document.createElement('div');
    var inner_boundary = document.createElement('div');
    var p = document.createElement('p');
    var lb_img = document.createElement('img');
    
    lb.id = 'lightbox';
    lb_img.id = 'lightbox_img';
    
    
    
    $(lb).addClass('envato-tip');
    $(inner_boundary).addClass('inner-boundry');
    $('#lightbox').hide();
    
    document.body.appendChild(lb);
    lb.appendChild(lb_img);

    return lb;
}

function followmouse(ev)
{
    item_image = $(current_thumb).children("img")
    element_left_border = $(current_thumb).offset().left;
    element_right_border = element_left_border + item_image.width();
    element_top_border = $(current_thumb).offset().top + 14;
    element_bottom_border = element_top_border - item_image.height(); 

    if ((ev.pageX > element_left_border) && (ev.pageX < element_right_border) && (ev.pageY > element_bottom_border) && (ev.pageY < element_top_border) )
    {  
        // Move lightbox
        var lightbox = $('#lightbox');
        var margin = 10;
        var mouseOffset = 20;
        var viewX = $(window).width() - margin;
        var viewY = $(window).height() - margin;
        var viewTop = $(window).scrollTop();
        var viewLeft = $(window).scrollLeft();
        
        var mouseX = ev.pageX;
        var mouseY = ev.pageY;
        var dimX = 600;
        var dimY = 310;

        // keep lightbox to right of mouse if room allows
        if((mouseX - viewLeft + dimX + mouseOffset) < viewX){
          var left = mouseX + mouseOffset;
        }else{
          var left = viewX - dimX;
        }
        // keep lightbox below mouse if room allows
        if((mouseY - viewTop) < (viewY / 2)){
          var top = mouseY + mouseOffset;
        }else{
          var top = mouseY - dimY - mouseOffset;
        }

        lightbox.css("position", 'absolute'); 
        lightbox.css("top", top + "px"); 
        lightbox.css("left", left + 'px'); 
        lightbox.css("zIndex", 1100);
    }   
    else
    {
        // Close lightbox
        $('#lightbox').remove();
        $().unbind('mousemove');
        current_thumb = null;
    }
}

function showlightbox(thumb, image_url)
{
    if(!current_thumb)
    {   
        var lb = createlightbox();
        var lb_img = $('#lightbox_img');
        lb_img.attr({src: image_url});
        $('#lightbox').show();
        $().mousemove(function(e){followmouse(e)});
        current_thumb = thumb;
        $(current_thumb).children('img').removeAttr('title');
   }
}

