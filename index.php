<?php
/**
 *  使い方
 *
 * contents.txtというファイルに記事を書く。
 * １行目が件名、２行目は空行、３行目以降が本文。
 *
 * 必要なファイル：
 * - ./contents.txt
 * - ./writer.js
 * - ./style.css
 * - ./mt/mt-static/support/*
 * - ./mt/mt-static/themes-base/*
 *
 */
$filename = isset($_GET['file']) ? $_GET['file'] : 'contents.txt';
$app = parseFile($filename);

$tplFile = 'entry.tpl';
$tpl = file_get_contents($tplFile);

$tpl = str_replace('{{$title}}', $app['title'], $tpl);
$tpl = str_replace('{{$body}}',  $app['body'], $tpl);

echo $tpl;

/**
 *  @return array('title' => '...', 'body' => '...')
 */
function parseFile($filename)
{
    $path = dirname(__FILE__) . '/' . $filename;
    if (! is_file($path)) {
        die('contents.txt not found');
    }
    $lines = file($path);

    $app = array();
    $app['title'] = array_shift($lines);
    array_shift($lines);
    $app['body'] = join('', $lines);
    return $app;
}
?>
