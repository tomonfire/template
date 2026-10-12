#[tokio::main]
async fn main() {
    let port = std::env::var("PORT").unwrap_or_else(|_| "8080".into());
    let listener = tokio::net::TcpListener::bind(format!("0.0.0.0:{port}"))
        .await
        .expect("bind port");
    println!("listening on http://localhost:{port}");
    axum::serve(listener, app::app()).await.expect("server");
}
