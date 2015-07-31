var PostList = React.createClass({
  render: function() {
    var posts = this.props.posts;
    return (
      <div>
        <div className='container'>
          {posts.map(post => {
            var props = _.merge(post, { key: `${post.type}-${post.id}` });
            return React.createElement(eval(post.type + "ListElement"), props);
          })}
        </div>
      </div>
    );
  }
});
