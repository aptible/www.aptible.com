module.exports = function(grunt) {
    'use strict';

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

        auto_install: {
            local: {}
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
                partials: 'src/partials/**/*.*',
                data: 'config.yml',
                collections: [{
                    name: 'pages',
                    sortby: 'posted',
                    sortorder: 'descending'
                }]
            },
            legal: {
                options: {
                    layout: 'legal_page.hbs'
                },
                files: [{
                    cwd: 'content/legal',
                    dest: 'dist/legal',
                    expand: true,
                    src: ['**/*.md', '**/*.hbs', '!**/readme.md', '!**/README.md']
                }, {
                    cwd: 'src/templates/legal',
                    dest: 'dist/legal',
                    expand: true,
                    src: ['**/*.hbs']
                }]
            },
            pages: {
                options: {
                    layout: 'page.hbs'
                },
                files: [{
                    cwd: 'content/pages',
                    dest: 'dist/',
                    expand: true,
                    src: ['**/*.md', '**/*.hbs', '!**/readme.md', '!**/README.md']
                }]
            },
            caseStudies: {
                options: {
                    layout: 'case-study.hbs'
                },
                files: [{
                    cwd: 'content/pages/case-studies',
                    dest: 'dist/case-studies',
                    expand: true,
                    src: ['**/*.md', '**/*.hbs']
                }]
            },
            technology: {
                options: {
                    layout: 'technology.hbs'
                },
                files: [{
                    cwd: 'content/pages/technology',
                    dest: 'dist/technology',
                    expand: true,
                    src: ['*.md', '*.hbs']
                }]
            },
            posts: {
                options: {
                    layout: 'post.hbs',
                },
                files: [{
                    cwd: 'content/posts',
                    dest: 'dist/blog',
                    expand: true,
                    src: ['**/*.md', '**/*.hbs', '!**/readme.md', '!**/README.md']
                }, {
                    cwd: 'src/templates/blog',
                    dest: 'dist/blog',
                    expand: true,
                    src: ['**/*.hbs']
                }]
            },
            errors: {
                layout: 'error.hbs',
                files: [{
                    cwd: 'src/templates/errors',
                    dest: 'dist/errors',
                    expand: true,
                    src: ['**/*.hbs']
                }]
            }
        },

        compass: {
            options: {
                bundleExec: true,
                config: 'compass.rb'
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
                    repository: 'https://github.com/aptible/aptible-legal.git',
                    directory: 'content/legal'
                }
            },
            pages: {
                options: {
                    branch: 'master',
                    repository: 'https://github.com/aptible/aptible-pages.git',
                    directory: 'content/pages'
                }
            },
            blog: {
                options: {
                    branch: 'master',
                    repository: 'https://github.com/aptible/aptible-blog.git',
                    directory: 'content/posts'
                }
            }
        },

        gitpull: {
            legal: {
                options: {
                    branch: 'master',
                    cwd: 'content/legal'
                }
            },
            pages: {
                options: {
                    branch: 'master',
                    cwd: 'content/pages'
                }
            },
            blog: {
                options: {
                    branch: 'master',
                    cwd: 'content/posts'
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
                    cwd: 'vendor/modernizr',
                    src: ['**/*.*'],
                    dest: 'dist/assets/modernizr'
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
                    cwd: 'vendor/rangeslider.js/dist',
                    src: ['*.js'],
                    dest: 'dist/assets/js/'
                },
                {
                    expand: true,
                    cwd: 'vendor/fullpage.js',
                    src: ['*.js'],
                    dest: 'dist/assets/js/'
                },
                {
                    expand: true,
                    cwd: 'node_modules/animateplus',
                    src: ['*.min.js'],
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
                },
                {
                    expand: true,
                    cwd: 'src/assets/',
                    src: ['favicon.ico', 'docs/*.*'],
                    dest: 'dist/assets/'
                }
                ]
            }
        },

        watch: {
            options: {
                interrupt: true
            },
            vendor: {
                files: [
                'vendor/**/*.*'
                ],
                tasks: ['assemble', 'compass:site', 'coffee:compile']
            },
            assemble: {
                files: [
                'content/**/*.hbs',
                'content/**/*.md',
                'src/templates/**/*.*',
                'src/layouts/**/*.*',
                'src/helpers/**/*.*',
                'src/partials/**/*.*',
                'src/assets/images/**/*.*'],
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
        },

        exec: {
            s3_sync: {
                cmd: function(bucket) {
                    var acl = ' --acl public-read';
                    var cc = ' --cache-control max-age=300,s-maxage=300';
                    return 'aws s3 sync' + acl + cc + ' dist/ s3://' + bucket;
                }
            }
        }
    });

    grunt.loadNpmTasks('grunt-auto-install');
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
    grunt.loadNpmTasks('grunt-exec');
    grunt.loadNpmTasks('assemble');

    grunt.registerTask('require_setup', 'Ensures repo is setup', function() {
        var dependencies = ['vendor/aptible-sass', 'content/legal', 'content/pages', 'content/posts', 'node_modules'],
        i = 0;

        for (i = 0; i < dependencies.length; i++) {
            if (!grunt.file.exists(dependencies[i])) {
                console.log(dependencies[i] + ' missing!');
                grunt.fail.fatal('>> You must run grunt setup!');
            }
        }
    });

    grunt.registerTask('install', 'install dependencies', function() {
        var exec = require('child_process').exec;
        var cb = this.async();
        exec('bundle install; npm install; bower install', {}, function(err, stdout, stderr) {
            console.log(stdout);
            cb();
        });
    });

    grunt.registerTask('env', 'Set environment variable', function(env) {
        console.log(grunt.config.get('assemble.options.data'));
        grunt.config.set('assemble.options.env', env);
    });

    grunt.registerTask('setup', ['install', 'auto_install', 'gitclone']);
    grunt.registerTask('update', ['require_setup', 'gitpull']);
    grunt.registerTask('dist', ['require_setup', 'install', 'clean', 'copy:assets', 'assemble', 'compass:site', 'coffee:compile']);
    grunt.registerTask('release:production', ['env:production', 'dist', 'exec:s3_sync:www.aptible.com']);
    grunt.registerTask('release:staging', ['env:staging', 'dist', 'exec:s3_sync:www.aptible-staging.com']);
    grunt.registerTask('server', ['dist', 'connect', 'watch']);
    grunt.registerTask('default', ['server']);
};
