body {
  background-image: url(;
  background-position: center;
  background-size: cover;
  background-attachment: fixed;
  background-blend-mode: lighten;
}

#table {
  display: flex;
  justify-content: center;
  text-align: center;
  align-items: center;
}

#table:hover {
  color: red;
}
td:hover {
  background-color: white;
}

@keyframes shake {
  0% { transform: translate(1px, 1px) rotate(0deg); }
  10% { transform: translate(-1px, -2px) rotate(-1deg); }
  20% { transform: translate(-3px, 0px) rotate(1deg); }
  30% { transform: translate(3px, 2px) rotate(0deg); }
  40% { transform: translate(1px, -1px) rotate(1deg); }
  50% { transform: translate(-1px, 2px) rotate(-1deg); }
  60% { transform: translate(-3px, 1px) rotate(0deg); }
  70% { transform: translate(3px, 1px) rotate(-1deg); }
  80% { transform: translate(-1px, -1px) rotate(1deg); }
  90% { transform: translate(1px, 2px) rotate(0deg); }
  100% { transform: translate(1px, -2px) rotate(-1deg); }
 }
 
 @keyframes bounceIn{
  0%{
    transform: scaleX(0.5);
    opacity: 0;
  }
  60%{
    transform: scaleX(1);
    opacity: 1;
  }
  100%{
    transform: scaleX(0.8);
  }
}

h1 {
  animation: bounceIn 4s infinite;
  animation-direction: alternate;
  animation-timing-function: ease-in-out;
}