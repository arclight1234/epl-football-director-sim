# 다른 컴퓨터에서 이어서 작업하기

원격 저장소는 GitHub의 비공개 저장소 `arclight1234/epl-football-director-sim`입니다.

## 가장 쉬운 방법

1. 다른 컴퓨터에서 GitHub에 `arclight1234` 계정으로 로그인한다.
2. 저장소 페이지를 연다.
3. GitHub Desktop의 **Open with GitHub Desktop** 또는 명령줄의 아래 주소로 저장소를 복제한다.

```text
https://github.com/arclight1234/epl-football-director-sim.git
```

4. 새 Codex 작업에서 복제한 폴더를 프로젝트로 연다.
5. `README.md`, `docs/DESIGN.md`, `docs/DECISIONS.md`, `docs/ROADMAP.md`, `docs/CHAT_TRANSCRIPT.md`를 먼저 읽도록 요청하면 현재 설계 맥락을 이어갈 수 있다.

## 동기화 원칙

- 설계 합의가 생길 때마다 관련 문서와 대화 기록을 갱신한다.
- 작업을 마칠 때 커밋하고 `main`에 푸시한다.
- 다른 컴퓨터에서 시작할 때는 먼저 최신 변경사항을 가져온다.
- `work/`는 현재 컴퓨터 전용 임시 파일과 인증 정보를 담으므로 원격에 업로드하지 않는다.
- SSH 개인 키는 저장소에 포함되지 않는다. 다른 컴퓨터에서는 그 컴퓨터의 GitHub 로그인 또는 별도 인증을 사용한다.

