// Inspired by https://github.com/guillaumervls/react-infinite-scroll

var InfiniteScroll = React.createClass({
  getDefaultProps: function () {
    return {
      pageStart: 1,
      hasMore: true,
      loadMore: function () {},
      threshold: 250
    };
  },
  componentDidMount: function () {
    this.pageLoaded = this.props.pageStart;
    this.attachScrollListener();
  },
  componentDidUpdate: function () {
    this.attachScrollListener();
  },
  render: function () {
    var props = this.props;
    return React.DOM.div(null, props.children, props.hasMore && props.loader);
  },
  scrollListener: function () {
    var el = this.getDOMNode();
    // var scrollTop = (window.pageYOffset !== undefined) ? window.pageYOffset : (document.documentElement || document.body.parentNode || document.body).scrollTop;
    var scrollTop = el.parentNode.scrollTop;

    if (this.topPosition(el) + el.offsetHeight - scrollTop - window.innerHeight < Number(this.props.threshold)) {
      this.detachScrollListener();
      // call loadMore after detachScrollListener to allow
      // for non-async loadMore functions
      this.props.loadMore(this.pageLoaded += 1);
    }
  },
  attachScrollListener: function () {
    if (!this.props.hasMore) {
      return;
    }
    this.getDOMNode().parentNode.addEventListener('scroll', this.scrollListener);
  },
  detachScrollListener: function () {
    this.getDOMNode().parentNode.removeEventListener('scroll', this.scrollListener);
  },
  componentWillUnmount: function () {
    this.detachScrollListener();
  },
  topPosition: function(domElt) {
    if (!domElt) {
      return 0;
    }
    return domElt.offsetTop + this.topPosition(domElt.offsetParent);
  }
});
