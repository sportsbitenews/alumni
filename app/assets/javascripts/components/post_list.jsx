var PostList = React.createClass({
  render: function() {
    return (
      <div>
        {this.props.posts.map(post => {
          var props = _.merge(post, { key: `${post.type}-${post.id}` });
          return React.createElement(window[post.type + "ListElement"], props);
        })}
      </div>
    );
  }
});
