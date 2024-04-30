import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Particle.js configuration
    particlesJS("particles-js", {
      particles: {
        number: {
          value: 100,
          density: {
            enable: true,
            value_area: 800
          }
        },
        color: {
          value: "#00A693",
        },
        shape: {
          type: "polygon",
          polygon: {
            nb_sides: 6
          },
        },
        opacity: {
          value: 0.5,
          random: true,
          anim: {
            enable: true,
            speed: 0.1,
            opacity_min: 0.1,
            sync: false
          },
        },
        size: {
          value: 40,
          random: true,
          anim: {
            enable: true,
            speed: 5,
            size_min: 40,
            sync: false
          }
        },
        line_linked: {
          enable: false,
          distance: 300,
          color: "#00A693",
          opacity: 0.4,
          width: 2
        },
        interactivity: {
          detect_on: "canvas",
          events: {
            onhover: {
              enable: true,
              mode: "repulse"
            },
            onclick: {
              enable: true,
              mode: "push"
            },
            resize: true
          },
          modes: {
            grab: {
              distance: 800,
              line_linked: {
                opacity: 1
              }
            },
            bubble: {
              distance: 800,
              size: 80,
              duration: 2,
              opacity: 0.8,
              speed: 3
            },
            repulse: {
              distance: 400,
              duration: 0.4
            },
            push: {
              particles_nb: 4
            },
            remove: {
              particles_nb: 2
            }
          }
        }
      }
    });
  }
}
