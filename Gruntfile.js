module.exports = function (grunt) {
  'use strict';

  if(!grunt.file.exists('vendor/aptible-sass')) {
    grunt.fail.fatal('>> You must run grunt setup!');
  }

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    connect: {
      dev: {
        options: {
          port: 8000,
          base: 'dist/'
        }
      }
    },

    jshint: {
      all: ['Gruntfile.js', 'src/helpers/*.js'],
      options: {
        jshintrc: '.jshintrc'
      }
    },
    assemble: {
      options: {
        assets: 'dist/assets',
        helpers: ['helper-moment', 'src/helpers/**/*.js'],
        layout: 'application.hbs',
        layoutdir: 'src/layouts/',
        partials: 'src/partials/**/*',
        data: 'config.yml'
      },
      legal: {
        options: {
          layout: 'legal_page.hbs'
        },
        files: [
          {
            cwd: 'content/legal',
            dest: 'dist/legal',
            expand: true,
            src: ['**/*.md', '**/*.hbs']
          },
          {
            cwd: 'src/templates/legal',
            dest: 'dist/legal',
            expand: true,
            src: ['**/*.hbs']
          }
        ]
      },
      pages: {
        options: {
          layout: 'page.hbs'
        },
        files: [
          {
            cwd: 'content/pages',
            dest: 'dist/',
            expand: true,
            src: ['**/*.md', '**/*.hbs']
          }
        ]
      },
      posts: {
        options: {
          layout: 'post.hbs',
        },
        files: [
          {
            cwd: 'content/posts',
            dest: 'dist/blog',
            expand: true,
            src: ['**/*.md', '**/*.hbs', '!**/readme.md']
          },
          {
            cwd: 'src/templates/blog',
            dest: 'dist/blog',
            expand: true,
            src: ['**/*.hbs']
          }
        ]
      }
    },

    compass: {
      options: {
      },
      site: {
        options: {
          sassDir: 'src/assets/stylesheets',
          cssDir: 'dist/assets/css',
          // imagesDir has to be relative to dist on the client, but at
          // compass compile time it's relative to the Gruntfile.
          // Grunt will throw ugly warnings, but it works
          imagesDir: 'assets/images'
        }
      }
    },

    gitclone: {
      legal: {
        options: {
          branch: 'master',
          repository: 'git@github.com:aptible/legal.git',
          directory: 'content/legal'
        }
      },
      pages: {
        options: {
          branch: 'rehaul',
          repository: 'git@github.com:aptible/www.aptible.com.git',
          directory: 'content/pages'
        }
      },
      blog: {
        options: {
          branch: 'master',
          repository: 'git@github.com:aptible/blog.aptible.com.git',
          directory: 'content/posts'
        }
      }
    },

    clean: {
      src: ['dist']
    },

    coffee: {
      compile: {
        options: {
          sourceMap: true
        },
        files: {
          'dist/assets/js/app.js': ['src/assets/javascript/**/*.coffee']
        }
      }
    },

    copy: {
      assets: {
        files: [
          {
            expand: true,
            cwd: 'vendor/font-awesome/fonts',
            src: ['*.*'],
            dest: 'dist/assets/fonts/'
          },
          {
            expand: true,
            cwd: 'vendor/bootstrap-sass-official/vendor/assets/fonts/bootstrap',
            src: ['*.*'], dest: 'dist/assets/css/bootstrap/'
          },
          {
            expand: true,
            cwd: 'vendor/bootstrap-sass-official/vendor/assets/javascripts/bootstrap',
            src: ['*.*'],
            dest: 'dist/assets/js/'
          },
          {
            expand: true,
            cwd: 'vendor/slick-carousel/slick',
            src: ['**/*.*'],
            dest: 'dist/assets/slick'
          },
          {
            expand: true,
            cwd: 'vendor/aptible-sass/dist/images',
            src: ['*.*'],
            dest: 'dist/assets/images/'
          },
          {
            expand: true,
            cwd: 'vendor/jquery/dist',
            src: ['*.js'],
            dest: 'dist/assets/js/'
          },
          {
            expand: true,
            cwd: 'content/posts/assets',
            src: ['**/*.*'],
            dest: 'dist/blog/assets/'
          },
          {
            expand: true,
            cwd: 'content/legal/assets',
            src: ['**/*.*'],
            dest: 'dist/legal/assets/'
          },
          {
            expand: true,
            cwd: 'content/pages/assets',
            src: ['**/*.*'],
            dest: 'dist/pages/assets/'
          },
          {
            expand: true,
            cwd: 'src/assets/images',
            src: ['**/*.*'],
            dest: 'dist/assets/images/'
          }
        ]
      }
    },

    watch: {
      options: {
        interrupt: true
      },
      assemble: {
        files: ['content/**/*.hbs', 'content/**/*.md'],
        tasks: 'assemble'
      },
      css: {
        files: 'src/assets/stylesheets/**/*.*',
        tasks: 'compass:site'
      },
      coffee: {
        files: 'src/assets/javascript/**/*.*',
        tasks: 'coffee:compile'
      }
    }
  });

  grunt.loadNpmTasks('grunt-git');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-sync-pkg');
  grunt.loadNpmTasks('assemble');

  grunt.registerTask('setup', 'Installs bower, npm, and content dependencies', function() {

    var exec = require('child_process').exec,
      cb = this.async(),
      underline = ['\x1B[4m', '\x1B[24m'],
      onComplete = function(e, stdout, stderr) {
        if(stdout) { console.log(stdout); }
        if(stderr) { console.log(stderr); }
        cb();
      };

      console.log(underline[0] + 'Running "npm install" task' + underline[1]);
      exec('npm install', {}, onComplete);

      console.log(underline[0] + 'Running "bower install" task' + underline[1]);
      exec('bower install', {}, onComplete);

      exec('grunt gitclone:all', {}, onComplete);
    });

  grunt.registerTask('watch:all', ['watch:assemble', 'watch:css', 'watch:coffee']);
  grunt.registerTask('gitclone:all', ['gitclone:legal', 'gitclone:blog', 'gitclone:pages']);
  grunt.registerTask('dist',['clean', 'gitclone:all', 'copy:assets', 'assemble', 'compass:site', 'coffee:compile']);
  grunt.registerTask('release', ['dist']);
  grunt.registerTask('server', ['dist', 'connect', 'watch']);
};