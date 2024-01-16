


function validateImageUrl(url) {
    // Regular expression to match image URLs that start with https and end with .png, .jpeg, .webp, or .gif
    var pattern = /^https:\/\/.*\.(png|jpeg|jpg|webp|gif)$/i;
    return pattern.test(url);
  }
  
 

  function verifForm(event) {
    var form = document.getElementById("gameFormModal");
    // Fetch form field values
    var name = document.getElementById("game_name").value.trim();
    var banner = document.getElementById("game_banner").value.trim();
    var price = document.getElementById("game_price").value.trim();
    var isValid = true;
    var errorMessage = "";

    // Check if the name has at least 3 characters
    if (name.length < 3) {
      isValid = false;
      errorMessage += "Le champ nom doit contenir au moins 3 caractères. ";
    }

    // Validate image URL
    if (!validateImageUrl(banner)) {
      isValid = false;
      errorMessage += " L'URL de la bannière doit être une URL d'image valide (https)";
    }

    // Check if the price is provided
    if (!price) {
      isValid = false;
      errorMessage += "Le champ prix est obligatoire , mais pour un jeu gratuit mettez 0. ";
    }

    // If any validations fail, prevent form submission and show error message
    if (!isValid) {
      event.preventDefault();
      var errorDiv = document.getElementById("error_message");
      if (!errorDiv) {
        errorDiv = document.createElement("div");
        errorDiv.id = "error_message";
        console.log(form.children)
        console.log(form.children[0])
        form.children[0].appendChild(errorDiv);
      }
      errorDiv.textContent = errorMessage;
      errorDiv.className = "apple-style-error";
    }
  }
  
    //FUNCTION CARD ANIMATION 
  
  function parallax(carte,perpective=255,style2=false){carte.forEach(el =>{
    el.addEventListener("mousemove", e =>{
  
        let elrect = el.getBoundingClientRect()
  
        let x = e.clientX - elrect.x
        let y = e.clientY - elrect.y
  
        let midcardwidth = elrect.width / 2
        let midcardheight = elrect.height / 2
        let angleY = -(x - midcardwidth) / 8
        let angleX = (y - midcardheight) / 8.5
  
        let glowX = x / elrect.width * 100
        let glowY = y / elrect.height * 100
  
        if(style2==true){
        if (angleX < -30) angleX = -15
        if (angleY < -10) angleY = -6
        }
        el.style.transition = "all 0.1s "
        el.style.transform =  `perspective(${perpective}px)  rotateX(${angleX}deg) rotateY(${angleY}deg)`;
  
  
  
    })
    el.addEventListener("mouseleave",()=>{
  
  
        el.style.transition = "all 0.3s "
        el.style.transform = "rotateX(0) rotateY(0) "
    })
    // el.addEventListener("mouseleave",()=>{
  
    //     el.children[1].style.opacity=0.2
    //     el.children[0].style.opacity = 1
    //     el.style.transition = all 0.5s 
    //     el.style.transform = rotateX(0) rotateY(0) 
    // })
    // el.addEventListener("mouseover",()=>{
    //   el.style.transition = all 1s 
    //   el.style.background=none
    //   el.children[0].style.opacity = 1
    // })
    console.log("ok")
  
  })}
  
  if(document.querySelectorAll('.game')){
    setTimeout(()=>{
        let cartes = document.querySelectorAll('.game');
        parallax(cartes,perpective=834);
    },1300)
    
  }
  window.addEventListener("load",()=>{
    let cartes = document.querySelectorAll('.game');
    parallax(cartes,perpective=834);
  
  
  
  }
  )















function updateTime() {
    const now = new Date();
    let hours = now.getHours();
    const minutes = now.getMinutes();
    const period = hours >= 12 ? 'PM' : 'AM';

    // Convert to 12-hour format
    hours = hours % 12;
    hours = hours ? hours : 12; // the hour '0' should be '12'

    // Format the time string
    const timeStr = `${hours}:${minutes < 10 ? '0' + minutes : minutes}`;

    // Update the HTML
    
    document.getElementById('hours').textContent = timeStr;
    document.getElementById('period').textContent = period;
}


// setInterval(updateTime, 60000);
// updateTime();





function closeModal() {
  if (document.getElementById("error_message")){
    setTimeout(function(){document.getElementById("error_message").remove()},600)

  }
  var modal = document.getElementById('gameFormModal');
  var modalContent = modal.querySelector('.modal-content');

  // Animate the modal content scale down and reduce opacity
  modalContent.animate([
    { opacity: 1, transform: 'scale(1)' },
    { opacity: 0, transform: 'scale(0.8)' }
  ], {
    duration: 230,
    easing: 'ease-in',
    fill: 'forwards'
  });

  // Animate the backdrop shadow fade out
  var backdropAnimation = modal.animate([
    { opacity: 1 },
    { opacity: 0 }
  ], {
    duration: 230,
    fill: 'forwards'
  });

  // After the backdrop animation is finished, hide the modal
  backdropAnimation.onfinish = function() {
    modal.style.display = 'none';
  };
}



function openModal() {
    var modal = document.getElementById('gameFormModal');
    var modalContent = modal.querySelector('.modal-content');
    
    // Display the modal
    modal.style.display = 'flex'; 

    // Animate the backdrop shadow with opacity
    modal.animate([
      { opacity: 0 },
      { opacity: 1 }
    ], {
      duration: 180,
      fill: 'forwards'
    });

    modalContent.animate([
      { opacity: 0, transform: 'scale(0.8)' },
      { opacity: 1, transform: 'scale(1.05)' },
      { opacity: 1, transform: 'scale(0.95)' },
      { opacity: 1, transform: 'scale(1)' }
    ], {
      duration: 500, // Duration is slightly longer to accommodate the bounce
      easing: 'cubic-bezier(0.34, 1.56, 0.64, 1)', // Cubic bezier for bounce
      fill: 'forwards'
    });
  };