var CommentBox = React.createClass({
  getInitialState: function() {
    return {data: []};
  },
  loadCommentsFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        if(data.is_success == 0) {
          return
        }
        this.setState({data: data.results.data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  handleCommentSubmit: function(comment) {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      type: 'POST',
      data: comment,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  componentDidMount: function() {
    this.loadCommentsFromServer();
    setInterval(this.loadCommentsFromServer, this.props.pollInterval);
  },
  render: function() {
    return (
      <div className="commentBox">
        <CommentList data={this.state.data} />
        <CommentForm onCommentSubmit={this.handleCommentSubmit} />
      </div>
    );
  }
});

var CommentList = React.createClass({
  render: function() {
    var commentNodes = this.props.data.map(function (comment) {
      return (
        <Comment key={comment.id} comment={comment} />
      );
    });
    return (
      <div className="ui comments">
        <h3 className="ui dividing header">Comments</h3>
        {commentNodes}
      </div>
    );
  }
});

var CommentForm = React.createClass({
  handleSubmit: function(e) {
    e.preventDefault();
    var comment = React.findDOMNode(this.refs.comment).value.trim();
    if (!comment) {
      return;
    }
    this.props.onCommentSubmit({comment: comment});
    React.findDOMNode(this.refs.comment).value = '';
    return;
  },
  render: function() {
    return (
      <form className="ui reply form" onSubmit={this.handleSubmit}>
        <div className="field">
          <textarea ref="comment"></textarea>
        </div>
        <input type="submit" className="ui blue submit icon button" value="post" />
      </form>
    );
  }
});

var Comment = React.createClass({
  render: function() {
    return (
      <div className="comment">
        <a className="avatar">
          <img src={this.props.comment.image}/>
        </a>
        <div className="content">
          <a className="author">{this.props.comment.name}</a>
          <div className="metadata">
            <span className="date">{this.props.comment.time_ago}</span>
          </div>
          <div className="text">
            {this.props.comment.comment}
          </div>
        </div>
      </div>
    );
  }
});

var comments_url = `/kiita_api/comments/${article_id}`
React.render(
  <CommentBox url={comments_url} pollInterval={2000} />,
  document.getElementById('comment_area')
);
