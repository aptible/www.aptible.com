(function() {
  var PriceCalculator, TechNetwork, TechNetworkLine, addJobs, adjustContentHeight, analyticsReady, techAnimation, validateEmail,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  analyticsReady = function() {
    var $notice, $noticeClose, $noticeMessage, hideMargin, newNotice;
    if ($(document).data('analyticsCalled')) {
      return;
    }
    $(document).data('analyticsCalled', true);
    $notice = $('.notice');
    $noticeClose = $notice.find('.notice__close');
    $noticeMessage = $notice.find('.notice__message');
    try {
      newNotice = analytics.user().traits().header_banner_notice !== $noticeMessage.attr('href');
    } catch (_error) {
      newNotice = true;
    }
    if (!(location.pathname === '/' && $notice.length > 0 && newNotice)) {
      return $notice.remove();
    } else {
      hideMargin = "-" + ($notice.outerHeight()) + "px";
      $notice.css({
        marginTop: hideMargin,
        display: 'block'
      });
      setTimeout((function() {
        return $notice.removeClass('no-animation');
      }), 100);
      $noticeMessage.on('click', function() {
        try {
          return analytics.identify({
            header_banner_notice: $noticeMessage.attr('href')
          });
        } catch (_error) {}
      });
      $noticeClose.on('click', function() {
        $noticeClose.hide();
        $notice.css('marginTop', hideMargin);
        setTimeout((function() {
          return $notice.css('display', 'none');
        }), 3000);
        try {
          analytics.identify({
            header_banner_notice: $noticeMessage.attr('href')
          });
        } catch (_error) {}
        return false;
      });
      return setTimeout((function() {
        return $notice.css('margin-top', 0);
      }), 1000);
    }
  };

  $(document).ready(function() {
    $('.alert').alert();
    analytics.ready(analyticsReady);
    return setTimeout(analyticsReady, 1000);
  });

  $(function() {
    var $lists;
    $lists = $("ul[data-collapsable='true'], ol[data-collapsable='true']");
    return $lists.on('click', function() {
      var $list;
      $list = $(this);
      if ($list.is("[data-is-collapsed='true']")) {
        $list.attr('data-is-collapsed', false);
      } else {
        $list.attr('data-is-collapsed', true);
      }
      return false;
    });
  });

  $(function() {
    var $viewport;
    if ($('.full-service-hipaa-compliance').length > 0) {
      $viewport = $('html, body');
      return $("a[href^='#']").on('click', function() {
        $viewport.animate({
          scrollTop: $($(this).attr('href')).offset().top
        }, 750, 'swing');
        return false;
      });
    }
  });

  $(document).ready(function() {
    $.fn.extend({
      contactForm: function() {
        return this.each(function() {
          var alertText, email, form, from, message, messageContainer, name;
          form = $(this);
          name = form.find('input[name="name"]');
          email = form.find('input[name="email"]');
          message = form.find('textarea[name="description"]');
          from = form.find('input[name="submitted_from"]');
          messageContainer = form.find('.alert').hide();
          alertText = messageContainer.find('.text');
          return form.on('submit', function(e) {
            var emailVal, messageVal, nameVal;
            from.val(document.location.href);
            nameVal = name.val();
            emailVal = email.val();
            messageVal = message.val();
            if (nameVal && emailVal && messageVal) {
              messageContainer.attr('class', 'alert').hide();
              messageContainer.addClass('alert-success').show();
              alertText.text('Thanks for your message!');
              setTimeout((function() {
                name.val('');
                email.val('');
                return message.val('');
              }), 50);
              return true;
            } else {
              messageContainer.addClass('alert-danger').show();
              alertText.text('Name, Email, and Message are all required fields.');
              return false;
            }
          });
        });
      }
    });
    return $('.contact-form form').contactForm();
  });

  validateEmail = function(email) {
    var re;
    re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
  };

  $(function() {
    $.fn.extend({
      eBookForm: function() {
        var _this;
        _this = this;
        return this.each(function() {
          var company, email, error, fname, form, lname, submit, success;
          form = $(this);
          email = form.find('input[name="email"]');
          submit = form.find('input[type="submit"]');
          fname = form.find('input[name="fname"]');
          lname = form.find('input[name="lname"]');
          company = form.find('input[name="company"]');
          success = form.find('.message.success');
          error = form.find('.message.danger');
          return form.on('submit', function(e) {
            var emailVal, traits;
            e.preventDefault();
            emailVal = email.val();
            submit.attr('disabled', 'disabled');
            error.hide();
            success.hide();
            if (emailVal && validateEmail(emailVal)) {
              analytics.page();
              traits = {
                email: emailVal,
                name: "" + (fname.val()) + " " + (lname.val()),
                company_name: company.val()
              };
              if (_this.identified()) {
                analytics.identify(analytics.user().id(), traits);
              } else {
                analytics.identify(emailVal, traits);
              }
              success.show();
              if (form.data('ebook')) {
                return _this.trackEBook(form.data('ebook'), traits);
              }
            } else {
              error.show();
              return submit.removeAttr('disabled');
            }
          });
        });
      },
      identified: function() {
        return typeof analytics.user().id === 'function' && analytics.user().id();
      },
      trackEBook: function(path, traits) {
        var book;
        if (traits == null) {
          traits = {};
        }
        book = path.split('/').reverse()[0];
        traits.book = book;
        analytics.track('Downloaded eBook', traits);
        return window.location.href = path;
      },
      eBookDownload: function() {
        return this.each((function(_this) {
          return function() {
            return $(_this).on('click', function(e) {
              e.preventDefault();
              if (_this.identified()) {
                analytics.identify(analytics.user().id());
              }
              return _this.trackEBook($(_this).attr('href'));
            });
          };
        })(this));
      }
    });
    $('.ebook-form').eBookForm();
    if (window.location.pathname.indexOf('ebooks') > -1) {
      return $("a[href$='.pdf']").eBookDownload();
    }
  });

  $(function() {
    if (window.devicePixelRatio === 2) {
      return $("img[src$='product-stack.png']").attr('src', '/assets/images/product-stack-2x.png');
    }
  });

  addJobs = function(job_data) {
    var commitment, excerpt, index, link, location, posting, posting_html, team, _i, _len;
    posting_html = [];
    index = 0;
    for (_i = 0, _len = job_data.length; _i < _len; _i++) {
      posting = job_data[_i];
      excerpt = $.trim(posting.description).split('\n')[0];
      location = posting.categories.location;
      commitment = posting.categories.commitment;
      team = posting.categories.team;
      link = posting.hostedUrl;
      if (index === 0 || index % 2 === 0) {
        posting_html.push('<div class="row">');
      }
      posting_html.push('<div class="job col-md-6 col-sm-12 col-xs-12">' + ("<a class='job-title' href='" + link + "'>" + posting.text + "</a>") + ("<p class='tags'><span>" + team + "</span><span>" + location + "</span><span>" + commitment + "</span></p>") + ("<p class='description'>" + excerpt + "</p>") + ("<a class='btn btn-primary' href='" + link + "'>Learn more</a>") + '</div>');
      if (index !== 0 && ((index + 1) % 2 === 0 || index === (job_data.length - 1))) {
        posting_html.push('</div>');
      }
      index++;
    }
    return $('.openings').html(posting_html.join(''));
  };

  $(document).ready(function() {
    return $.ajax({
      dataType: 'json',
      url: 'https://api.lever.co/v0/postings/aptible?mode=json',
      success: addJobs
    });
  });

  $(function() {
    var $amountViews, $containersInput, $disksInput, $doc, $domainsInput, $fullServiceToggle, $phiToggle, $priceCalc, $priceCalcButton, $priceViews, $rangeKeys, $ranges, setSliderKey;
    $priceCalc = $('.price-calc');
    if ($priceCalc.length > 0) {
      $doc = $(document);
      window.priceCalc = new PriceCalculator();
      $phiToggle = $('.toggle[data-name="phi"]');
      $fullServiceToggle = $('.toggle[data-name="full-service"]');
      $containersInput = $('input[data-type="containers"]');
      $disksInput = $('input[data-type="disks"]');
      $domainsInput = $('input[data-type="domains"]');
      $priceCalcButton = $('.price-calc__submit');
      $rangeKeys = {
        containers: $('.price-calc__range-keys[data-type="containers"]'),
        disks: $('.price-calc__range-keys[data-type="disks"]'),
        domains: $('.price-calc__range-keys[data-type="domains"]')
      };
      $amountViews = {
        containers: $('.price-calc__item-value--containers'),
        disks: $('.price-calc__item-value--disks'),
        domains: $('.price-calc__item-value--domains'),
        plan: $('.price-calc__plan-value')
      };
      $priceViews = {
        containers: $('.price-calc__item-price--containers'),
        disks: $('.price-calc__item-price--disks'),
        domains: $('.price-calc__item-price--domains'),
        plan: $('.price-calc__plan-price'),
        total: $('.price-calc__monthly-total')
      };
      $ranges = $('input[type="range"]');
      setSliderKey = function($keys, index) {
        $keys.find("[data-state='selected']").attr('data-state', '');
        return $keys.find('.price-calc__range-key').eq(index).attr('data-state', 'selected');
      };
      $ranges.rangeslider({
        polyfill: false,
        onSlide: function(position, value) {
          var item;
          item = this.$element.data('type');
          if (priceCalc[item] === value) {
            return;
          }
          if (!this.$element.is(':focus')) {
            this.$element.focus();
          }
          priceCalc.setValue(item, value);
          return $doc.trigger('updateViews', [priceCalc]);
        }
      });
      $phiToggle.on('click', function() {
        priceCalc.handlesPHI = $priceCalc.attr('data-phi') !== 'on';
        priceCalc.setDevBaseValues();
        if (!priceCalc.handlesPHI) {
          priceCalc.fullService = false;
        }
        $doc.trigger('updateViews', [priceCalc]);
        return false;
      });
      $fullServiceToggle.on('click', function() {
        priceCalc.fullService = $priceCalc.attr('data-full-service') !== 'on';
        $doc.trigger('updateViews', [priceCalc]);
        return false;
      });
      $priceCalcButton.on('click', function() {
        return !priceCalc.needsMore();
      });
      $doc.on('updateViews', function(event, priceCalc) {
        var baseUrl;
        $phiToggle.attr('data-state', priceCalc.toOnOff('handlesPHI'));
        $priceCalc.attr('data-phi', priceCalc.toOnOff('handlesPHI'));
        $amountViews.plan.html(priceCalc.baseCost());
        $priceViews.plan.html(priceCalc.baseCost());
        $fullServiceToggle.attr('data-state', priceCalc.toOnOff('fullService'));
        $priceCalc.attr('data-full-service', priceCalc.toOnOff('fullService'));
        $containersInput.val(priceCalc.containers).change();
        setSliderKey($rangeKeys.containers, priceCalc.containers);
        if (!(priceCalc.containers > 10)) {
          $amountViews.containers.html(priceCalc.containers);
          $priceViews.containers.html(priceCalc.containersCost());
        }
        $disksInput.val(priceCalc.disks).change();
        setSliderKey($rangeKeys.disks, priceCalc.disks);
        if (!(priceCalc.disks > 10)) {
          $amountViews.disks.html(priceCalc.diskSize());
          $priceViews.disks.html(priceCalc.disksCost());
        }
        $domainsInput.val(priceCalc.domains).change();
        setSliderKey($rangeKeys.domains, priceCalc.domains);
        if (!(priceCalc.domains > 10)) {
          $amountViews.domains.html(priceCalc.domains);
          $priceViews.domains.html(priceCalc.domainsCost());
        }
        $priceCalc.attr('data-needs-more', priceCalc.needsMoreOnOff());
        $priceViews.total.html(priceCalc.price());
        baseUrl = $priceCalcButton.attr('href').split('?')[0];
        $priceCalcButton.attr('href', "" + baseUrl + "?" + ($.param(priceCalc.toParams())));
        if (priceCalc.needsMore() && !priceCalc.fullService) {
          return $priceCalcButton.attr('disabled', 'disabled');
        } else {
          return $priceCalcButton.removeAttr('disabled');
        }
      });
      return $doc.trigger('updateViews', [priceCalc]);
    }
  });

  PriceCalculator = (function() {
    function PriceCalculator() {}

    PriceCalculator.prototype.handlesPHI = false;

    PriceCalculator.prototype.fullService = false;

    PriceCalculator.prototype.containers = 2;

    PriceCalculator.prototype.disks = 1;

    PriceCalculator.prototype.domains = 1;

    PriceCalculator.prototype.prevContainers = 0;

    PriceCalculator.prototype.prevDisks = 0;

    PriceCalculator.prototype.prevDomains = 0;

    PriceCalculator.prototype.phiContainers = 6;

    PriceCalculator.prototype.phiDisks = 8;

    PriceCalculator.prototype.phiDomains = 4;

    PriceCalculator.prototype.diskValuesGB = [0, 10, 20, 50, 100, 250, 500, 750, 1000, 1500, 2000];

    PriceCalculator.prototype.diskLabels = ['0 GB', '10 GB', '20 GB', '50 GB', '100 GB', '250 GB', '500 GB', '750 GB', '1 TB', '1.5 TB', '2 TB'];

    PriceCalculator.prototype.perContainer = (0.08 * 730).toFixed(2);

    PriceCalculator.prototype.perDisk = function(gb) {
      return (0.37 * gb).toFixed(2);
    };

    PriceCalculator.prototype.perDomain = (0.05 * 730).toFixed(2);

    PriceCalculator.prototype.phiBaseCost = 999;

    PriceCalculator.prototype.setDevBaseValues = function() {
      if (this.handlesPHI) {
        this.prevContainers = this.containers;
        this.prevDisks = this.disks;
        this.prevDomains = this.domains;
        this.containers = Math.max(this.containers, this.phiContainers);
        this.disks = Math.max(this.disks, this.phiDisks);
        return this.domains = Math.max(this.domains, this.phiDomains);
      } else {
        this.containers = this.prevContainers;
        this.disks = this.prevDisks;
        return this.domains = this.prevDomains;
      }
    };

    PriceCalculator.prototype.setValue = function(attr, value) {
      var attrCap;
      attrCap = attr[0].toUpperCase() + attr.slice(1);
      if (this.handlesPHI && value >= this["phi" + attrCap]) {
        this["prev" + attrCap] = value;
      }
      return this[attr] = value;
    };

    PriceCalculator.prototype.diskSize = function() {
      return this.diskLabels[this.disks];
    };

    PriceCalculator.prototype.containersCost = function() {
      var containers, includedContainers;
      includedContainers = this.handlesPHI ? this.phiContainers : 0;
      containers = this.containers > 10 ? 10 : this.containers;
      return this.toCurrency(Math.max((containers - includedContainers) * this.perContainer, 0));
    };

    PriceCalculator.prototype.disksCost = function() {
      var diskGB, gb, includedGB;
      includedGB = this.diskValuesGB[this.handlesPHI ? this.phiDisks : 0];
      diskGB = this.diskValuesGB[this.disks > 10 ? 10 : this.disks];
      gb = Math.max(diskGB - includedGB, 0);
      return this.toCurrency(parseFloat(this.perDisk(gb)));
    };

    PriceCalculator.prototype.domainsCost = function() {
      var domains, includedDomains;
      includedDomains = this.handlesPHI ? this.phiDomains : 0;
      domains = this.domains > 10 ? 10 : this.domains;
      return this.toCurrency(Math.max((domains - includedDomains) * this.perDomain, 0));
    };

    PriceCalculator.prototype.baseCost = function() {
      return this.toCurrency(this.handlesPHI ? this.phiBaseCost : 0);
    };

    PriceCalculator.prototype.price = function() {
      return this.toCurrency(parseFloat(this.baseCost()) + parseFloat(this.containersCost()) + parseFloat(this.disksCost()) + parseFloat(this.domainsCost()));
    };

    PriceCalculator.prototype.plan = function() {
      if (this.handlesPHI) {
        return 'plantform';
      } else if (this.fullService) {
        return 'managed';
      } else {
        return 'development';
      }
    };

    PriceCalculator.prototype.needsMore = function() {
      return this.containers > 10 || this.disks > 10 || this.domains > 10;
    };

    PriceCalculator.prototype.needsMoreOnOff = function() {
      if (this.needsMore() && !this.fullService) {
        return 'on';
      } else {
        return 'off';
      }
    };

    PriceCalculator.prototype.toCurrency = function(num) {
      return num.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
    };

    PriceCalculator.prototype.toOnOff = function(attr) {
      if (this[attr]) {
        return 'on';
      } else {
        return 'off';
      }
    };

    PriceCalculator.prototype.toParams = function() {
      return {
        containers: this.containers,
        disk: this.disks,
        domains: this.domains,
        plan: this.handlesPHI ? 'platform' : 'development',
        val: this.price()
      };
    };

    return PriceCalculator;

  })();

  adjustContentHeight = function() {
    var sibling_height, wrapper;
    sibling_height = 0;
    wrapper = $('.main');
    return wrapper.css('min-height', $(window).height() - (200 + 43 + 356));
  };

  $(document).ready(function() {
    return adjustContentHeight();
  });

  $(window).resize(function() {
    return adjustContentHeight();
  });

  $(function() {
    var $viewport;
    if ($('.faq').length > 0) {
      $viewport = $('html, body');
      return $("a[href^='#']").on('click', function() {
        $viewport.animate({
          scrollTop: $($(this).attr('href')).offset().top
        }, 750, 'swing');
        return false;
      });
    }
  });

  $(document).ready(function() {
    var credCarousel;
    return credCarousel = $('.credibility-carousel').slick({
      accessibility: true,
      autoplay: false,
      centerMode: true,
      infinite: true,
      speed: 1000,
      variableWidth: true
    });
  });

  $(function() {
    var $container, $doc, $techAnim;
    $techAnim = $('.technology');
    if ($techAnim.length > 0) {
      $doc = $(document);
      window.techAnim = new techAnimation();
      $container = $('.slides');
      return $container.fullpage({
        verticalCentered: false,
        css3: true,
        navigation: true,
        navigationPosition: 'left',
        navigationTooltips: ['', 'Stack', 'Network', 'Secure Load Balancing', 'Apps', 'Team Access', 'Databases', 'Scaling', 'Signup'],
        anchors: ['intro-tech', 'stack-tech', 'network-tech', 'secure-load-balancing-tech', 'apps-tech', 'team-access-tech', 'databases-tech', 'scaling-tech', 'signup-tech'],
        showActiveTooltip: true,
        keyboardScrolling: false,
        afterLoad: function(anchorLink, index) {
          return techAnim.play[index - 1].call(this);
        },
        onLeave: function(index, nextIndex, direction) {
          var click, _ref;
          click = (_ref = Math.abs(nextIndex - index) !== 1) != null ? _ref : {
            "true": false
          };
          if (click) {
            $('.slides, .fixed-diagram, .fixed-console, .network-container').fadeOut(50);
            return techAnim.clickOn[nextIndex - 1].call(this);
          } else if (nextIndex - index === 1) {
            return techAnim.leave[index - 1].call(this);
          } else if (nextIndex - index === -1) {
            return techAnim.leaveUp[index - 2].call(this);
          }
        },
        afterRender: function() {
          return $container.css('opacity', 1);
        }
      });
    }
  });

  techAnimation = (function() {
    var Helpers, awsTitle, clickApp, clickBastion, clickDatabse, clickGateway, clickInfrastructure, clickIntro, clickNetwork, clickReset, clickScaling, clickSignup, createNetwork, finalInfrastructureState, fixedConsole, fixedDiagram, infrastructure, intro, leaveApp, leaveBastion, leaveDatabase, leaveGateway, leaveInfrastructure, leaveIntro, leaveNetwork, leaveScaling, leaveUpApp, leaveUpBastion, leaveUpDatabase, leaveUpGateway, leaveUpInfrastructure, leaveUpNetwork, leaveUpScaling, leaveUpSignup, network, playApp, playBastion, playDatabase, playGateway, playInfrastructure, playIntro, playNetwork, playScaling, playSignup, scaling, stopInfrastructure;

    function techAnimation() {}

    awsTitle = $('.diagram .title');

    fixedDiagram = $('.fixed-diagram');

    fixedConsole = $('.fixed-console');

    network = null;

    intro = {
      played: false
    };

    infrastructure = {
      played: false,
      copyAnim: null,
      circleAnim: null,
      privateAnim: null
    };

    scaling = {
      half2: null
    };

    Helpers = {
      staggerType: function(char, $src, delay) {
        return setTimeout((function() {
          return $src.append(char);
        }), delay);
      },
      typeConsole: function(str, $src) {
        var delay, i, max, min, _i, _ref, _results;
        max = 80;
        min = 0;
        _results = [];
        for (i = _i = 0, _ref = str.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
          delay = Math.floor(Math.random() * (max - min)) + min + (i * max);
          _results.push(this.staggerType(str[i], $src, delay));
        }
        return _results;
      }
    };

    playIntro = function() {
      animate({
        el: '.console',
        easing: 'easeOutCirc',
        opacity: [0, 1],
        translateY: [1000, 0],
        duration: 1500,
        delay: 100
      });
      setTimeout((function() {
        return $('#intro .copy').removeClass('disappear');
      }), 300);
      if (!intro.played) {
        intro.played = true;
        animate({
          el: '.intro-header',
          easing: 'easeOutCirc',
          opacity: [0, 1],
          duration: 1500,
          delay: 1600
        });
        animate({
          el: '.intro-text',
          easing: 'easeOutQuad',
          opacity: [0, 1],
          duration: 1500,
          delay: 1900
        });
        animate({
          el: '.primary-header',
          easing: 'easeOutQuad',
          opacity: [0, 1],
          duration: 1000,
          delay: 2300
        });
        return setTimeout((function() {
          var $src;
          $src = $('.b1-text');
          return Helpers.typeConsole('aptible account:create', $src);
        }), 2000);
      }
    };

    playInfrastructure = function() {
      if (infrastructure.played) {
        $('.load-balancer, .app, .bastion, .database').removeClass('faded');
        $('.network-container').addClass('disappear');
        $('#infrastructure .copy').removeClass('disappear');
        return awsTitle.css('color', 'rgba(255,255,255,0.3)');
      } else {
        animate({
          el: fixedDiagram,
          easing: 'easeOutQuad',
          opacity: [0, 1],
          translateY: [80, 0],
          duration: 300,
          delay: 600
        });
        infrastructure.copyAnim = setTimeout((function() {
          return $('#infrastructure .copy').removeClass('disappear');
        }), 400);
        animate({
          el: '.customer-vpc-dots',
          opacity: [0, 1],
          scaleX: [0.8, 1.0],
          scaleY: [0.8, 1.0],
          duration: 1200,
          delay: 1300
        });
        animate({
          el: '.loading-circle-1',
          opacity: [0, 1],
          scaleX: [0.8, 1.0],
          scaleY: [0.8, 1.0],
          duration: 1200,
          delay: 1400,
          complete: function(obj) {
            return $(obj).addClass('rotate-rev');
          }
        });
        animate({
          el: '.loading-circle-2',
          opacity: [0, 1],
          scaleX: [0.8, 1.0],
          scaleY: [0.8, 1.0],
          duration: 1200,
          delay: 1500,
          complete: function(obj) {
            return $(obj).addClass('rotate');
          }
        });
        animate({
          el: '.loading-text',
          easing: 'easeOutCirc',
          opacity: [0, 1],
          translateY: [10, 0],
          duration: 600,
          delay: 2000
        });
        infrastructure.circleAnim = setTimeout((function() {
          $('.loading-circle-1, .loading-circle-2, .loading-text').fadeOut();
          return $('.customer-vpc-dots, .customer-vpc').addClass('loaded');
        }), 3000);
        setTimeout((function() {
          return awsTitle.css('color', 'rgba(255,255,255,0.3)');
        }), 3600);
        animate({
          el: '.private',
          opacity: [0, 1],
          easing: 'easeOutCirc',
          duration: 400,
          delay: 4000
        });
        infrastructure.privateAnim = setTimeout((function() {
          return $('.private').addClass('loaded');
        }), 4200);
        animate({
          el: '.public span',
          opacity: [0, 1],
          translateY: [10, 0],
          duration: 1000,
          delay: 5400
        });
        animate({
          el: '.private span',
          opacity: [0, 1],
          translateY: [10, 0],
          duration: 1000,
          delay: 5700
        });
        animate({
          el: '.public .left, .public .right',
          easing: 'easeOutCirc',
          opacity: [0, 1],
          duration: 800,
          delay: 6500
        });
        animate({
          el: '.load-balancer, .app, .bastion, .database',
          easing: 'easeOutCirc',
          opacity: [0, 1],
          duration: 1200,
          delay: 7100
        });
        return infrastructure.finalAnim = setTimeout((function() {
          return infrastructure.played = true;
        }), 7000);
      }
    };

    playGateway = function() {
      $('.http, .ssh').addClass('faded');
      $('#network .copy').removeClass('disappear');
      setTimeout((function() {
        return $('.docker').addClass('faded');
      }), 100);
      if (!network) {
        network = new TechNetwork();
        return network.createNetwork();
      } else {
        return $('.network-container').removeClass('disappear');
      }
    };

    playNetwork = function() {
      $('.http, .load-balancer').removeClass('faded');
      return $('#load-balancing .copy').removeClass('disappear');
    };

    playApp = function() {
      $('.app').removeClass('faded');
      return $('#apps .copy').removeClass('disappear');
    };

    playBastion = function() {
      $('.ssh, .bastion').removeClass('faded');
      return $('#bastion .copy').removeClass('disappear');
    };

    playDatabase = function() {
      $('.database').removeClass('faded');
      return $('#database .copy').removeClass('disappear');
    };

    playScaling = function() {
      $('.load-balancer, .app, .bastion, .database').removeClass('faded');
      $('#scale .copy').removeClass('disappear');
      return scaling.half2 = setTimeout((function() {
        return network.runHalf2();
      }), 3000);
    };

    playSignup = function() {
      $('.load-balancer, .app, .bastion, .database').removeClass('faded');
      return $('#signup .copy').removeClass('disappear');
    };

    leaveIntro = function() {
      animate.stop('.console');
      animate({
        el: '.console',
        easing: 'easeOutQuad',
        translateY: [0, 50],
        opacity: [1, 0],
        duration: 400,
        delay: 50
      });
      if (infrastructure.played) {
        fixedDiagram.fadeIn(50);
        return animate({
          el: fixedDiagram,
          easing: "easeOutQuad",
          opacity: [0, 1],
          duration: 800
        });
      }
    };

    leaveInfrastructure = function() {
      $('#infrastructure .copy').addClass('disappear');
      if (!infrastructure.played) {
        fixedDiagram.fadeOut(50);
        stopInfrastructure();
        clickReset();
        if (!network) {
          return setTimeout((function() {
            return finalInfrastructureState();
          }), 100);
        }
      }
    };

    leaveGateway = function() {
      $('#network .copy').addClass('disappear');
      return network.runHttp();
    };

    leaveNetwork = function() {
      $('#load-balancing .copy').addClass('disappear');
      $('.http, .load-balancer').addClass('faded');
      return network.stop();
    };

    leaveApp = function() {
      $('#apps .copy').addClass('disappear');
      $('.app').addClass('faded');
      return network.runSSH();
    };

    leaveBastion = function() {
      $('#bastion .copy').addClass('disappear');
      $('.bastion').addClass('faded');
      $('.ssh').addClass('faded');
      return network.stop();
    };

    leaveDatabase = function() {
      $('#database .copy').addClass('disappear');
      return network.runHalf();
    };

    leaveScaling = function() {
      $('#scale .copy').addClass('disappear');
      clearTimeout(scaling.half2);
      return network.stop();
    };

    leaveUpInfrastructure = function() {
      animate({
        el: fixedDiagram,
        easing: "easeOutQuad",
        opacity: [1, 0],
        duration: 300
      });
      setTimeout((function() {
        return $('.fixed-console').fadeIn();
      }), 800);
      $('#infrastructure .copy').addClass('disappear');
      if (!infrastructure.played) {
        fixedDiagram.fadeOut(50);
        return clickReset((function() {
          return fixedConsole.fadeIn();
        }), false);
      }
    };

    leaveUpGateway = function() {
      setTimeout((function() {
        return $('#infrastructure .copy').removeClass('disappear');
      }), 500);
      return $('.http, .ssh, .load-balancer, .app, .bastion, .database').removeClass('faded');
    };

    leaveUpNetwork = function() {
      setTimeout((function() {
        return $('#network .copy').removeClass('disappear');
      }), 500);
      $('.http, .load-balancer').addClass('faded');
      return network.stop();
    };

    leaveUpApp = function() {
      setTimeout((function() {
        return $('#load-balancing .copy').removeClass('disappear');
      }), 500);
      $('.app').addClass('faded');
      return network.runHttp();
    };

    leaveUpBastion = function() {
      setTimeout((function() {
        return $('#apps .copy').removeClass('disappear');
      }), 500);
      $('.bastion').addClass('faded');
      $('.ssh').addClass('faded');
      return network.stop();
    };

    leaveUpDatabase = function() {
      setTimeout((function() {
        return $('#bastion .copy').removeClass('disappear');
      }), 500);
      $('.database').addClass('faded');
      return network.runSSH();
    };

    leaveUpScaling = function() {
      setTimeout((function() {
        return $('#database .copy').removeClass('disappear');
      }), 500);
      $('.http, .ssh, .load-balancer, .app, .bastion').addClass('faded');
      clearTimeout(scaling.half2);
      return network.stop();
    };

    leaveUpSignup = function() {
      setTimeout((function() {
        return $('#scale .copy').removeClass('disappear');
      }), 500);
      return network.runHalf();
    };

    finalInfrastructureState = function(show) {
      if (show == null) {
        show = true;
      }
      $('.customer-vpc-dots, .customer-vpc').css({
        transition: 'all 50ms linear',
        opacity: 1
      }).addClass('loaded');
      awsTitle.css('color', 'rgba(255,255,255,0.3)');
      $('.private').css({
        transition: 'all 50ms linear',
        opacity: 1
      }).addClass('loaded');
      $('.public span, .private span').css('opacity', 1);
      $('.public .left, .public .right').css('opacity', 1);
      $('.load-balancer, .app, .bastion, .database').css('opacity', 1).addClass('faded');
      animate({
        el: fixedDiagram,
        easing: 'easeOutQuad',
        opacity: [0, 1],
        duration: 300,
        delay: 100
      });
      return setTimeout((function() {
        if (show) {
          fixedDiagram.fadeIn();
        }
        $('.slides').fadeIn();
        infrastructure.played = true;
        return createNetwork();
      }), 500);
    };

    createNetwork = function() {
      if (!network) {
        network = new TechNetwork();
        return network.createNetwork();
      }
    };

    stopInfrastructure = function() {
      animate.stop('.console');
      animate.stop('.fixed-diagram');
      animate.stop('.customer-vpc-dots');
      animate.stop('.loading-circle-1');
      animate.stop('.loading-circle-2');
      animate.stop('.loading-text');
      animate.stop('.private');
      animate.stop('.public span');
      animate.stop('.private span');
      animate.stop('.public .left, .public .right');
      animate.stop('.load-balancer, .app, .bastion, .database');
      clearTimeout(infrastructure.copyAnim);
      clearTimeout(infrastructure.circleAnim);
      clearTimeout(infrastructure.privateAnim);
      clearTimeout(scaling.half2);
      return setTimeout((function() {
        $('.loading-circle-1, .loading-circle-2, .loading-text').remove();
        $('.diagram span.title').css('color', 'rgba(255,255,255,0.3)');
        return infrastructure.played = true;
      }), 500);
    };

    clickReset = function(callback, show) {
      if (show == null) {
        show = true;
      }
      stopInfrastructure();
      $('.copy').addClass('disappear');
      if (!network) {
        return setTimeout((function() {
          return finalInfrastructureState(show);
        }), 100);
      } else {
        network.stop();
        animate({
          el: fixedDiagram,
          easing: "easeOutQuad",
          opacity: [0, 1],
          duration: 50
        });
        $('.network-container').removeClass('disappear');
        $('.load-balancer, .app, .bastion, .database').css('opacity', 1).addClass('faded');
        return setTimeout((function() {
          $('.slides').fadeIn();
          return callback();
        }), 1000);
      }
    };

    clickIntro = function() {
      return clickReset(function() {
        return fixedConsole.fadeIn();
      });
    };

    clickInfrastructure = function() {
      return clickReset(function() {
        return fixedDiagram.fadeIn();
      });
    };

    clickGateway = function() {
      return clickReset(function() {
        fixedDiagram.fadeIn();
        return $('.network-container').fadeIn();
      });
    };

    clickNetwork = function() {
      return clickReset(function() {
        fixedDiagram.fadeIn();
        $('.network-container').fadeIn();
        return setTimeout((function() {
          return network.runHttp;
        }), 100);
      });
    };

    clickApp = function() {
      return clickReset(function() {
        fixedDiagram.fadeIn();
        return $('.network-container').fadeIn();
      });
    };

    clickBastion = function() {
      return clickReset(function() {
        fixedDiagram.fadeIn();
        $('.network-container').fadeIn();
        return setTimeout((function() {
          return network.runSSH;
        }), 100);
      });
    };

    clickDatabse = function() {
      return clickReset(function() {
        fixedDiagram.fadeIn();
        return $('.network-container').fadeIn();
      });
    };

    clickScaling = function() {
      return clickReset(function() {
        fixedDiagram.fadeIn();
        $('.network-container').fadeIn();
        return setTimeout((function() {
          return network.runHalf;
        }), 100);
      });
    };

    clickSignup = function() {
      return clickReset(function() {
        fixedDiagram.fadeIn();
        return $('.network-container').fadeIn();
      });
    };

    techAnimation.prototype.play = [playIntro, playInfrastructure, playGateway, playNetwork, playApp, playBastion, playDatabase, playScaling, playSignup];

    techAnimation.prototype.leave = [leaveIntro, leaveInfrastructure, leaveGateway, leaveNetwork, leaveApp, leaveBastion, leaveDatabase, leaveScaling];

    techAnimation.prototype.leaveUp = [leaveUpInfrastructure, leaveUpGateway, leaveUpNetwork, leaveUpApp, leaveUpBastion, leaveUpDatabase, leaveUpScaling, leaveUpSignup];

    techAnimation.prototype.clickOn = [clickIntro, clickInfrastructure, clickGateway, clickNetwork, clickApp, clickBastion, clickDatabse, clickScaling, clickSignup];

    return techAnimation;

  })();

  TechNetwork = (function() {
    var $networkContainer, $vpc, $vpcPosition, OFFSET, SPACING, allLines, destroyNetwork, generateLines, generateNetwork, halfLines, httpLines, numLines, regenerateNetwork, sshLines, vpcLeft, vpcTop, vpcWidth;

    function TechNetwork() {}

    OFFSET = 32;

    SPACING = 16;

    $networkContainer = null;

    $vpc = null;

    $vpcPosition = null;

    vpcTop = 0;

    vpcLeft = 0;

    vpcWidth = 0;

    numLines = 0;

    halfLines = 0;

    httpLines = [];

    sshLines = [];

    allLines = [];

    generateNetwork = function() {
      var vpcPosition;
      $vpc = $('.customer-vpc');
      vpcPosition = $vpc.offset();
      vpcTop = Math.floor(vpcPosition.top);
      vpcLeft = Math.floor(vpcPosition.left) + (OFFSET / 2);
      vpcWidth = $vpc.outerWidth() - OFFSET;
      numLines = Math.ceil(vpcWidth / SPACING);
      halfLines = Math.ceil(numLines * 0.65);
      if (!$networkContainer) {
        $networkContainer = $('<div class="network-container">');
      }
      $networkContainer.css({
        height: vpcTop + 'px',
        width: vpcWidth,
        left: vpcLeft + 'px'
      });
      $('body').append($networkContainer);
      return generateLines();
    };

    generateLines = function() {
      var i, line, lineObj, yPos, _i, _results;
      _results = [];
      for (i = _i = 0; 0 <= numLines ? _i < numLines : _i > numLines; i = 0 <= numLines ? ++_i : --_i) {
        yPos = i * SPACING;
        if (i < halfLines) {
          lineObj = new TechNetworkLine();
          lineObj.createLine(yPos, 'left');
          httpLines.push(lineObj);
        } else {
          lineObj = new TechNetworkLine();
          lineObj.createLine(yPos, 'right');
          sshLines.push(lineObj);
        }
        allLines = httpLines.concat(sshLines);
        line = lineObj.getDOMObject();
        _results.push($networkContainer.append(line));
      }
      return _results;
    };

    regenerateNetwork = function() {
      destroyNetwork();
      return generateNetwork();
    };

    destroyNetwork = function() {
      var i, _i, _ref;
      for (i = _i = 0, _ref = allLines.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        allLines[i].getDOMObject().remove();
        delete allLines[i];
      }
      httpLines = [];
      sshLines = [];
      return allLines = [];
    };

    $(window).resize(function() {
      var $techAnim;
      $techAnim = $('.technology');
      if ($techAnim.length > 0) {
        return regenerateNetwork();
      }
    });

    TechNetwork.prototype.createNetwork = function() {
      return generateNetwork();
    };

    TechNetwork.prototype.runHttp = function() {
      var i, _i, _ref, _results;
      _results = [];
      for (i = _i = 0, _ref = httpLines.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        if (i % 2 === 0) {
          _results.push(httpLines[i].startActivity());
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    TechNetwork.prototype.runSSH = function() {
      var i, _i, _ref, _results;
      _results = [];
      for (i = _i = 0, _ref = sshLines.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        if (i !== 0 && i % 2 === 0) {
          _results.push(sshLines[i].startActivity());
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    TechNetwork.prototype.runHalf = function() {
      var i, _i, _ref, _results;
      _results = [];
      for (i = _i = 0, _ref = allLines.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        if (i % 2 === 0) {
          _results.push(allLines[i].startActivity());
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    TechNetwork.prototype.runHalf2 = function() {
      var i, _i, _ref, _results;
      _results = [];
      for (i = _i = 0, _ref = allLines.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        if (i % 2 !== 0) {
          _results.push(allLines[i].startActivity());
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    TechNetwork.prototype.stop = function() {
      var i, _i, _ref, _results;
      _results = [];
      for (i = _i = 0, _ref = allLines.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        _results.push(allLines[i].stopActivity());
      }
      return _results;
    };

    return TechNetwork;

  })();

  TechNetworkLine = (function() {
    function TechNetworkLine() {
      this.step = __bind(this.step, this);
      this.start = null;
      this.startTime = null;
      this.line = $('<div class="network-line">');
      this.dot = null;
      this.active = null;
      this.animating = null;
    }

    TechNetworkLine.prototype.randomTime = function(max, min) {
      return (Math.random() * (max - min) + min) * 1000;
    };

    TechNetworkLine.prototype.step = function(timestamp) {
      var progress, stepping;
      if (!this.start) {
        this.start = timestamp;
      }
      progress = timestamp - this.start;
      stepping = Math.min(progress / 20, 96);
      this.active.css('transform', 'scaleY(' + stepping / 100 + ')');
      this.dot.css('top', stepping + '%');
      if (progress < 2000) {
        return this.animating = window.requestAnimationFrame(this.step);
      } else {
        this.resetActivity();
        return this.animating = window.requestAnimationFrame(this.step);
      }
    };

    TechNetworkLine.prototype.resetActivity = function() {
      this.active.css('transform', 'scaleY(0)');
      this.dot.css('top', '0%');
      return this.start = null;
    };

    TechNetworkLine.prototype.showActive = function() {
      animate({
        el: this.dot,
        easing: 'easeOutCirc',
        opacity: [0, 1],
        duration: 500
      });
      return animate({
        el: this.active,
        easing: 'easeOutCirc',
        opacity: [0, 1],
        duration: 500
      });
    };

    TechNetworkLine.prototype.hideActive = function() {
      animate({
        el: this.dot,
        easing: 'easeOutCirc',
        opacity: [1, 0],
        duration: 500
      });
      return animate({
        el: this.active,
        easing: 'easeOutCirc',
        opacity: [1, 0],
        duration: 500
      });
    };

    TechNetworkLine.prototype.createLine = function(yPos, klass) {
      this.line.addClass(klass);
      this.line.css('left', yPos + "px");
      this.active = $('<div class="active">');
      this.dot = $('<div class="dot">');
      this.line.append(this.active).append(this.dot);
      return this.startTime = this.randomTime(0, 3);
    };

    TechNetworkLine.prototype.getDOMObject = function() {
      return this.line;
    };

    TechNetworkLine.prototype.startActivity = function() {
      this.showActive();
      return setTimeout(((function(_this) {
        return function() {
          return _this.animating = window.requestAnimationFrame(_this.step);
        };
      })(this)), this.startTime);
    };

    TechNetworkLine.prototype.stopActivity = function() {
      this.hideActive();
      return setTimeout(((function(_this) {
        return function() {
          window.cancelAnimationFrame(_this.animating);
          _this.animating = null;
          return _this.resetActivity();
        };
      })(this)), 600);
    };

    return TechNetworkLine;

  })();

}).call(this);

//# sourceMappingURL=app.js.map
